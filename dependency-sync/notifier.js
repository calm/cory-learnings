/**
 * Notification System
 * Sends alerts via Slack, email, and GitHub for dependency updates
 */

const https = require('https');
const { NOTIFICATION_CHANNELS } = require('./config');

class Notifier {
  /**
   * Send Slack notification
   */
  async notifySlack(type, data) {
    if (!NOTIFICATION_CHANNELS.slack.enabled) return;

    const messages = {
      success: {
        color: '#36a64f',
        title: '✅ Dependency Updated',
        text: `${data.package}@${data.version} auto-applied to ${data.project}`,
      },
      failure: {
        color: '#ff0000',
        title: '❌ Update Failed',
        text: `Failed to update ${data.package} in ${data.project}: ${data.reason}`,
      },
      'manual-review': {
        color: '#ffa500',
        title: '👤 Manual Review Needed',
        text: `${data.package}@${data.version} (${data.changeType}) in ${data.project}`,
      },
      summary: {
        color: '#0099ff',
        title: '📊 Sync Complete',
        text: `Applied: ${data.applied}/${data.total} | Pending: ${data.pendingReview}`,
      },
    };

    const message = messages[type] || messages.summary;

    const payload = {
      attachments: [
        {
          fallback: message.title,
          color: message.color,
          title: message.title,
          text: message.text,
          ts: Math.floor(Date.now() / 1000),
        },
      ],
    };

    return this.postWebhook(NOTIFICATION_CHANNELS.slack.webhookUrl, payload);
  }

  /**
   * Send email notification
   */
  async notifyEmail(type, data) {
    if (!NOTIFICATION_CHANNELS.email.enabled) return;

    const subject = {
      success: `✅ ${data.package} updated in ${data.project}`,
      failure: `❌ Update failed: ${data.package} in ${data.project}`,
      'manual-review': `👤 Review needed: ${data.package} in ${data.project}`,
      summary: `📊 Dependency Sync Summary`,
    };

    const body = {
      success: `Package ${data.package}@${data.version} has been automatically updated and all tests passed.`,
      failure: `Failed to update ${data.package}: ${data.reason} - ${data.details}`,
      'manual-review': `Manual review required for ${data.package}@${data.version} (${data.changeType} change)\n\nRecommendation: ${data.recommendation}`,
      summary: `Sync Results:\n- Applied: ${data.applied}\n- Failed: ${data.failed || 0}\n- Pending Review: ${data.pendingReview}\n- Timestamp: ${data.timestamp}`,
    };

    // In production, integrate with email service (SendGrid, AWS SES, etc.)
    console.log(`📧 Email to ${NOTIFICATION_CHANNELS.email.recipient}:`);
    console.log(`Subject: ${subject[type]}`);
    console.log(`Body: ${body[type]}\n`);
  }

  /**
   * Create GitHub PR for manual review
   */
  async createGitHubPR(projectPath, data) {
    if (!NOTIFICATION_CHANNELS.github.enabled) return;

    // In production, use octokit to create PR
    console.log(`🔗 GitHub PR needed for ${data.package}@${data.version} in ${projectPath}`);
    // This would integrate with GitHub API
  }

  /**
   * Post webhook (generic)
   */
  postWebhook(url, payload) {
    return new Promise((resolve, reject) => {
      const data = JSON.stringify(payload);

      const options = {
        hostname: new URL(url).hostname,
        port: 443,
        path: new URL(url).pathname + new URL(url).search,
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Content-Length': data.length,
        },
      };

      const req = https.request(options, (res) => {
        let body = '';
        res.on('data', (chunk) => (body += chunk));
        res.on('end', () => resolve(body));
      });

      req.on('error', reject);
      req.write(data);
      req.end();
    });
  }

  /**
   * Main notify method
   */
  async notify(type, data) {
    console.log(`📢 Notifying: ${type}`);
    await this.notifySlack(type, data);
    await this.notifyEmail(type, data);
    if (type === 'manual-review') {
      await this.createGitHubPR(data.project, data);
    }
  }
}

module.exports = Notifier;
