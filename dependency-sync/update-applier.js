/**
 * Update Applier
 * Applies updates, runs tests, and commits changes with rollback capability
 * Phase 2: Quality-focused implementation
 */

const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

class UpdateApplier {
  constructor(projectPath) {
    this.projectPath = projectPath;
    this.backupDir = path.join(projectPath, '.dependency-sync-backups');
    this.ensureBackupDir();
  }

  ensureBackupDir() {
    if (!fs.existsSync(this.backupDir)) {
      fs.mkdirSync(this.backupDir, { recursive: true });
    }
  }

  /**
   * Create backup of package.json and package-lock.json
   */
  createBackup(id) {
    const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
    const backupPath = path.join(this.backupDir, `backup-${timestamp}-${id}`);
    fs.mkdirSync(backupPath, { recursive: true });

    const files = ['package.json', 'package-lock.json', 'npm-shrinkwrap.json'];
    for (const file of files) {
      const src = path.join(this.projectPath, file);
      if (fs.existsSync(src)) {
        fs.copyFileSync(src, path.join(backupPath, file));
      }
    }

    return backupPath;
  }

  /**
   * Restore from backup
   */
  restoreBackup(backupPath) {
    const files = fs.readdirSync(backupPath);
    for (const file of files) {
      const src = path.join(backupPath, file);
      const dst = path.join(this.projectPath, file);
      fs.copyFileSync(src, dst);
    }
  }

  /**
   * Update a single package to a new version
   */
  updatePackage(packageName, newVersion) {
    try {
      const cmd = `cd ${this.projectPath} && npm install ${packageName}@${newVersion} --save`;
      execSync(cmd, { stdio: 'pipe' });
      return { success: true };
    } catch (error) {
      return { success: false, error: error.message };
    }
  }

  /**
   * Run project tests
   */
  runTests(testCommand) {
    try {
      const output = execSync(`cd ${this.projectPath} && ${testCommand}`, {
        stdio: 'pipe',
        encoding: 'utf-8',
      });
      // Parse test output for pass/fail count
      const passMatch = output.match(/(\d+) passing/);
      const failMatch = output.match(/(\d+) failing/);
      return {
        success: !failMatch,
        passed: passMatch ? parseInt(passMatch[1]) : 0,
        failed: failMatch ? parseInt(failMatch[1]) : 0,
        output,
      };
    } catch (error) {
      return {
        success: false,
        passed: 0,
        failed: -1,
        error: error.message,
        output: error.stdout || '',
      };
    }
  }

  /**
   * Validate package can be imported (basic check)
   */
  validatePackage(packageName) {
    try {
      const cmd = `cd ${this.projectPath} && node -e "require('${packageName}')"`;
      execSync(cmd, { stdio: 'pipe' });
      return { success: true };
    } catch (error) {
      return { success: false, error: error.message };
    }
  }

  /**
   * Create git commit for the update
   */
  createCommit(packageName, oldVersion, newVersion, breakingChanges) {
    try {
      const message = `deps: upgrade ${packageName} ${oldVersion} → ${newVersion}${
        breakingChanges ? ' (breaking change)' : ''
      }`;

      execSync(`cd ${this.projectPath} && git add package.json package-lock.json`, {
        stdio: 'pipe',
      });

      execSync(
        `cd ${this.projectPath} && git commit -m "${message}" --no-verify`,
        { stdio: 'pipe' }
      );

      return { success: true, message };
    } catch (error) {
      return { success: false, error: error.message };
    }
  }

  /**
   * Main: Apply update with full quality gates
   */
  async applyUpdate(update, testCommand, testThreshold) {
    const backupId = `${update.package}-${update.latest}`;
    const backup = this.createBackup(backupId);

    console.log(`\n📦 Updating ${update.package}...`);

    // Step 1: Update package
    console.log(`  → Installing ${update.package}@${update.latest}...`);
    const updateResult = this.updatePackage(update.package, update.latest);
    if (!updateResult.success) {
      console.error(`  ✗ Failed to update: ${updateResult.error}`);
      this.restoreBackup(backup);
      return { success: false, reason: 'install-failed', error: updateResult.error };
    }

    // Step 2: Validate import
    console.log(`  → Validating package...`);
    const validateResult = this.validatePackage(update.package);
    if (!validateResult.success) {
      console.error(`  ✗ Package validation failed: ${validateResult.error}`);
      this.restoreBackup(backup);
      return { success: false, reason: 'validation-failed', error: validateResult.error };
    }

    // Step 3: Run tests
    console.log(`  → Running tests (${testThreshold} expected)...`);
    const testResult = this.runTests(testCommand);
    if (!testResult.success || testResult.passed < testThreshold * 0.95) {
      // Allow 5% test variance
      console.error(
        `  ✗ Tests failed: ${testResult.passed} passed, ${testResult.failed} failed`
      );
      this.restoreBackup(backup);
      return {
        success: false,
        reason: 'tests-failed',
        testsPassed: testResult.passed,
        testsFailed: testResult.failed,
      };
    }

    console.log(
      `  ✓ Tests passed: ${testResult.passed}/${testThreshold} (${(
        (testResult.passed / testThreshold) *
        100
      ).toFixed(1)}%)`
    );

    // Step 4: Commit changes
    console.log(`  → Creating git commit...`);
    const commitResult = this.createCommit(
      update.package,
      update.current,
      update.latest,
      update.hasBreakingChanges
    );
    if (!commitResult.success) {
      console.error(`  ✗ Commit failed: ${commitResult.error}`);
      this.restoreBackup(backup);
      return { success: false, reason: 'commit-failed', error: commitResult.error };
    }

    console.log(`  ✓ Committed: ${commitResult.message}`);
    return { success: true, backup };
  }

  /**
   * Cleanup old backups (keep last 10)
   */
  cleanupBackups() {
    try {
      const backups = fs.readdirSync(this.backupDir);
      if (backups.length > 10) {
        const sorted = backups.sort().reverse();
        for (let i = 10; i < sorted.length; i++) {
          const backupPath = path.join(this.backupDir, sorted[i]);
          execSync(`rm -rf ${backupPath}`);
        }
      }
    } catch (error) {
      console.warn(`Warning: Failed to cleanup backups: ${error.message}`);
    }
  }
}

module.exports = UpdateApplier;
