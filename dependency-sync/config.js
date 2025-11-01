/**
 * Central Dependency Sync Configuration
 * Manages all project dependencies and update strategies
 */

const PROJECTS = {
  'calm-couples': {
    path: '~/Desktop/calm/calm-couples',
    checkInterval: 'weekly',
    testCommand: 'npm test',
    testThreshold: 63,
    critical: true,
    dependencies: [
      { package: '@supabase/supabase-js', updateStrategy: 'auto-patch', critical: true },
      { package: '@stripe/stripe-js', updateStrategy: 'auto-patch', critical: true },
      { package: 'react', updateStrategy: 'manual-major', critical: true },
      { package: 'tailwindcss', updateStrategy: 'auto-minor', critical: false },
      { package: 'framer-motion', updateStrategy: 'auto-patch', critical: false },
    ],
    externalServices: [
      { name: 'Supabase', type: 'database', healthcheck: 'https://supabase.com/status' },
      { name: 'Stripe', type: 'payment', healthcheck: 'https://status.stripe.com' },
    ],
  },

  'ios-automation': {
    path: '~/Desktop/calm/ios-automation',
    checkInterval: 'weekly',
    testCommand: 'npm run test:all',
    testThreshold: 648,
    critical: true,
    dependencies: [
      { package: '@anthropic-ai/sdk', updateStrategy: 'auto-minor', critical: true },
      { package: 'playwright', updateStrategy: 'auto-minor', critical: true },
      { package: 'webdriverio', updateStrategy: 'auto-minor', critical: true },
      { package: 'jest', updateStrategy: 'auto-patch', critical: true },
    ],
    externalServices: [],
  },

  'calm-ai-project-manager': {
    path: '~/Desktop/calm/calm-ai-project-manager',
    checkInterval: 'twice-weekly',
    testCommand: 'npm test',
    testThreshold: 105,
    critical: true,
    dependencies: [
      { package: '@anthropic-ai/sdk', updateStrategy: 'auto-minor', critical: true },
      { package: '@prisma/client', updateStrategy: 'auto-minor', critical: true },
      { package: 'express', updateStrategy: 'auto-patch', critical: true },
      { package: 'axios', updateStrategy: 'auto-patch', critical: false },
    ],
    externalServices: [
      { name: 'Anthropic', type: 'ai-api', healthcheck: 'https://api.anthropic.com' },
      { name: 'Jira', type: 'api', healthcheck: 'https://jira.atlassian.com' },
      { name: 'Confluence', type: 'api', healthcheck: null },
      { name: 'Slack', type: 'api', healthcheck: null },
      { name: 'GitHub', type: 'api', healthcheck: 'https://status.github.com' },
      { name: 'Linear', type: 'api', healthcheck: null },
      { name: 'Zoom', type: 'api', healthcheck: 'https://status.zoom.us' },
    ],
  },
};

const UPDATE_STRATEGIES = {
  'auto-patch': {
    description: 'Automatically update PATCH versions (e.g., 1.2.3 → 1.2.4)',
    semver: '1.2.x',
    requiresReview: false,
    runTests: true,
    autoMerge: true,
  },
  'auto-minor': {
    description: 'Automatically update MINOR versions (e.g., 1.2.3 → 1.3.0)',
    semver: '1.x.0',
    requiresReview: false,
    runTests: true,
    autoMerge: true,
  },
  'manual-major': {
    description: 'Manual review required for MAJOR versions (e.g., 1.0.0 → 2.0.0)',
    semver: 'x.0.0',
    requiresReview: true,
    runTests: true,
    autoMerge: false,
  },
};

const NOTIFICATION_CHANNELS = {
  slack: {
    webhookUrl: process.env.SLACK_WEBHOOK_URL,
    enabled: !!process.env.SLACK_WEBHOOK_URL,
  },
  email: {
    recipient: process.env.ALERT_EMAIL,
    enabled: !!process.env.ALERT_EMAIL,
  },
  github: {
    enabled: true,
    prReviewers: ['@cory-weinstein'],
  },
};

module.exports = {
  PROJECTS,
  UPDATE_STRATEGIES,
  NOTIFICATION_CHANNELS,
  CHECK_TIMES: {
    'weekly': '0 2 * * 1', // Monday 2 AM
    'twice-weekly': '0 2 * * 1,4', // Monday & Thursday 2 AM
  },
};
