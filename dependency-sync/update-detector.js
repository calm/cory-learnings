/**
 * Update Detector
 * Checks npm registry, GitHub releases, and external APIs for new versions
 * Cost-optimized: Uses caching and scheduled checks
 */

const https = require('https');
const fs = require('fs');
const path = require('path');

class UpdateDetector {
  constructor(cacheDir = '/tmp/dependency-sync-cache') {
    this.cacheDir = cacheDir;
    this.cacheTTL = 24 * 60 * 60 * 1000; // 24 hours
    this.ensureCacheDir();
  }

  ensureCacheDir() {
    if (!fs.existsSync(this.cacheDir)) {
      fs.mkdirSync(this.cacheDir, { recursive: true });
    }
  }

  /**
   * Get cache key for a package
   */
  getCacheKey(packageName) {
    return path.join(this.cacheDir, `${packageName.replace(/\//g, '_')}.json`);
  }

  /**
   * Check if cache is valid (within TTL)
   */
  isCacheValid(packageName) {
    const cacheFile = this.getCacheKey(packageName);
    if (!fs.existsSync(cacheFile)) return false;

    const stats = fs.statSync(cacheFile);
    const age = Date.now() - stats.mtimeMs;
    return age < this.cacheTTL;
  }

  /**
   * Get latest version from npm registry
   */
  async getLatestNpmVersion(packageName) {
    // Check cache first (Phase 1: cost-optimized)
    if (this.isCacheValid(packageName)) {
      const cached = JSON.parse(fs.readFileSync(this.getCacheKey(packageName)));
      return cached;
    }

    return new Promise((resolve, reject) => {
      https
        .get(`https://registry.npmjs.org/${packageName}/latest`, (res) => {
          let data = '';
          res.on('data', (chunk) => (data += chunk));
          res.on('end', () => {
            try {
              const parsed = JSON.parse(data);
              const result = {
                package: packageName,
                latest: parsed.version,
                published: parsed.time.modified,
                breaking: parsed.keywords?.includes('breaking') || false,
              };

              // Cache the result
              fs.writeFileSync(this.getCacheKey(packageName), JSON.stringify(result));
              resolve(result);
            } catch (e) {
              reject(new Error(`Failed to parse npm data for ${packageName}`));
            }
          });
        })
        .on('error', reject);
    });
  }

  /**
   * Compare semantic versions
   * Returns: 'patch' | 'minor' | 'major' | 'none'
   */
  compareVersions(current, latest) {
    const [cMajor, cMinor, cPatch] = current.split('.').map(Number);
    const [lMajor, lMinor, lPatch] = latest.split('.').map(Number);

    if (lMajor > cMajor) return 'major';
    if (lMinor > cMinor) return 'minor';
    if (lPatch > cPatch) return 'patch';
    return 'none';
  }

  /**
   * Detect breaking changes by comparing CHANGELOG or GitHub releases
   */
  async detectBreakingChanges(packageName, currentVersion, newVersion) {
    // In production, this would:
    // 1. Fetch GitHub releases
    // 2. Parse CHANGELOG.md
    // 3. Look for "BREAKING CHANGE" keywords
    // 4. Analyze API changes via TypeScript defs

    // For now, return based on semver
    const changeType = this.compareVersions(currentVersion, newVersion);
    return {
      hasBreakingChanges: changeType === 'major',
      changeType,
      recommendation:
        changeType === 'major' ? 'Manual review required' :
        changeType === 'minor' ? 'Recommend testing' :
        'Safe to auto-update',
    };
  }

  /**
   * Check health of external services
   */
  async checkServiceHealth(healthcheckUrl) {
    if (!healthcheckUrl) return { status: 'unknown' };

    return new Promise((resolve) => {
      https
        .get(healthcheckUrl, { timeout: 5000 }, (res) => {
          resolve({
            status: res.statusCode === 200 ? 'healthy' : 'degraded',
            statusCode: res.statusCode,
          });
        })
        .on('error', () => resolve({ status: 'unreachable' }))
        .on('timeout', () => resolve({ status: 'timeout' }));
    });
  }

  /**
   * Main: Check all updates for a project
   */
  async checkProjectUpdates(projectConfig) {
    const updates = [];

    for (const dep of projectConfig.dependencies) {
      try {
        const npmData = await this.getLatestNpmVersion(dep.package);

        // Get current version from package.json
        const packageJsonPath = `${projectConfig.path}/package.json`;
        const packageJson = JSON.parse(fs.readFileSync(packageJsonPath));
        const current = packageJson.dependencies[dep.package] || packageJson.devDependencies[dep.package];

        if (!current) continue;

        const breaking = await this.detectBreakingChanges(
          dep.package,
          current.replace(/[\^\~]/g, ''),
          npmData.latest
        );

        updates.push({
          package: dep.package,
          current: current.replace(/[\^\~]/g, ''),
          latest: npmData.latest,
          strategy: dep.updateStrategy,
          critical: dep.critical,
          ...breaking,
        });
      } catch (error) {
        console.error(`Error checking ${dep.package}:`, error.message);
      }
    }

    // Check external services
    const serviceHealth = [];
    for (const service of projectConfig.externalServices) {
      const health = await this.checkServiceHealth(service.healthcheck);
      serviceHealth.push({
        service: service.name,
        ...health,
      });
    }

    return {
      project: projectConfig.name,
      timestamp: new Date().toISOString(),
      updates,
      serviceHealth,
    };
  }
}

module.exports = UpdateDetector;
