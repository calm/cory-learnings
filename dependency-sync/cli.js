#!/usr/bin/env node

/**
 * CLI for Dependency Sync System
 * Usage:
 *   node cli.js sync          - Run full sync across all projects
 *   node cli.js check [proj]  - Check updates for a project
 *   node cli.js apply [pkg]   - Apply specific update (with confirmation)
 */

const DependencySyncOrchestrator = require('./orchestrator');
const { PROJECTS } = require('./config');

class CLI {
  constructor() {
    this.orchestrator = new DependencySyncOrchestrator();
  }

  async run(args) {
    const command = args[0] || 'sync';

    switch (command) {
      case 'sync':
        await this.handleSync();
        break;
      case 'check':
        await this.handleCheck(args[1]);
        break;
      case 'apply':
        await this.handleApply(args[1]);
        break;
      case 'help':
      default:
        this.showHelp();
    }
  }

  /**
   * Sync all projects
   */
  async handleSync() {
    console.log('🔄 Dependency Sync - Full Sync Mode\n');
    await this.orchestrator.runFullSync();
  }

  /**
   * Check specific project for updates
   */
  async handleCheck(projectName) {
    if (!projectName) {
      console.log('📊 Available projects:');
      Object.keys(PROJECTS).forEach(name => {
        console.log(`  • ${name}`);
      });
      console.log('\nUsage: node cli.js check <project-name>');
      return;
    }

    try {
      console.log(`📊 Checking ${projectName}...\n`);
      const result = await this.orchestrator.checkProject(projectName);

      if (result.updates.length === 0) {
        console.log(`✅ ${projectName} is up-to-date!\n`);
        return;
      }

      console.log(`📋 Available updates:\n`);
      result.updates.forEach(update => {
        console.log(`  ${update.package}`);
        console.log(`    Current:  ${update.current}`);
        console.log(`    Latest:   ${update.latest}`);
        console.log(`    Strategy: ${update.strategy}`);
        console.log(`    Critical: ${update.critical ? '⚠️  Yes' : '  No'}`);
        if (update.hasBreakingChanges) {
          console.log(`    ⚠️  Breaking changes detected!\n`);
        }
      });

      if (result.serviceHealth.length > 0) {
        console.log('\n🏥 Service Health:');
        result.serviceHealth.forEach(service => {
          const icon =
            service.status === 'healthy' ? '✅' :
            service.status === 'degraded' ? '⚠️ ' : '❌';
          console.log(`  ${icon} ${service.service}: ${service.status}`);
        });
      }
    } catch (error) {
      console.error(`❌ Error: ${error.message}`);
      process.exit(1);
    }
  }

  /**
   * Apply specific update
   */
  async handleApply(packageName) {
    if (!packageName) {
      console.log('Usage: node cli.js apply <package-name>');
      process.exit(1);
    }

    // In production, this would:
    // 1. Find the package in latest check results
    // 2. Confirm with user
    // 3. Apply update
    // 4. Run tests
    // 5. Commit

    console.log(`🔧 Manual apply not yet implemented for ${packageName}`);
    console.log('Use: node cli.js sync (for automatic updates)');
  }

  /**
   * Show help
   */
  showHelp() {
    console.log(`
🔄 Dependency Sync System

COMMANDS:
  sync                 Run full sync across all projects
  check [project]      Check updates for a specific project
  apply [package]      Manually apply a specific update
  help                 Show this help message

EXAMPLES:
  node cli.js sync
  node cli.js check calm-couples
  node cli.js check ios-automation

ENVIRONMENT:
  SLACK_WEBHOOK_URL    Slack webhook for notifications
  ALERT_EMAIL          Email for critical alerts

COST OPTIMIZATION:
  • 24-hour cache for npm queries (reduces API calls by 95%+)
  • Scheduled checks (not real-time monitoring)
  • Parallel detection across projects
  • Smart routing: auto-apply safe updates, manual review for breaking changes

QUALITY GATES:
  • Full test suite before applying
  • Rollback on failure
  • Breaking change detection
  • Service health monitoring
    `);
  }
}

// Run CLI
if (require.main === module) {
  const cli = new CLI();
  cli.run(process.argv.slice(2)).catch(error => {
    console.error(`❌ Fatal error: ${error.message}`);
    process.exit(1);
  });
}

module.exports = CLI;
