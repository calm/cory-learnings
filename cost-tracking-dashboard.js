#!/usr/bin/env node

/**
 * Cost Tracking Dashboard
 * Visualizes token usage and costs across all projects
 * Reads from ~/.claude/token-usage.log
 */

const fs = require('fs');
const path = require('path');
const http = require('http');
const url = require('url');
const os = require('os');

const PORT = 5000;
const TRACKER_FILE = path.join(os.homedir(), '.claude', 'token-usage.log');

// Parse log file
function parseTokenLog() {
  if (!fs.existsSync(TRACKER_FILE)) {
    return [];
  }

  const content = fs.readFileSync(TRACKER_FILE, 'utf-8');
  const lines = content.split('\n').filter(line => line.trim());

  return lines.map(line => {
    // Format: YYYY-MM-DD HH:MM:SS | project | task | X tokens | $Y.YY
    const parts = line.split('|').map(p => p.trim());
    if (parts.length < 5) return null;

    const [datetime, project, task, tokenStr, costStr] = parts;
    const tokens = parseInt(tokenStr.replace(' tokens', ''), 10);
    const cost = parseFloat(costStr.replace('$', ''));

    const [date, time] = datetime.split(' ');

    return {
      datetime,
      date,
      time,
      project,
      task,
      tokens,
      cost,
    };
  }).filter(Boolean);
}

// Calculate statistics
function calculateStats(logs) {
  const stats = {
    totalTokens: 0,
    totalCost: 0,
    byProject: {},
    byDate: {},
    byTask: {},
    logs: logs.length,
  };

  logs.forEach(log => {
    // Overall
    stats.totalTokens += log.tokens;
    stats.totalCost += log.cost;

    // By project
    if (!stats.byProject[log.project]) {
      stats.byProject[log.project] = { tokens: 0, cost: 0, count: 0 };
    }
    stats.byProject[log.project].tokens += log.tokens;
    stats.byProject[log.project].cost += log.cost;
    stats.byProject[log.project].count += 1;

    // By date
    if (!stats.byDate[log.date]) {
      stats.byDate[log.date] = { tokens: 0, cost: 0, count: 0 };
    }
    stats.byDate[log.date].tokens += log.tokens;
    stats.byDate[log.date].cost += log.cost;
    stats.byDate[log.date].count += 1;

    // By task
    if (!stats.byTask[log.task]) {
      stats.byTask[log.task] = { tokens: 0, cost: 0, count: 0, projects: new Set() };
    }
    stats.byTask[log.task].tokens += log.tokens;
    stats.byTask[log.task].cost += log.cost;
    stats.byTask[log.task].count += 1;
    stats.byTask[log.task].projects.add(log.project);
  });

  // Convert Sets to arrays for JSON serialization
  Object.keys(stats.byTask).forEach(key => {
    stats.byTask[key].projects = Array.from(stats.byTask[key].projects);
  });

  return stats;
}

// HTML UI
function generateHTML(stats, logs) {
  const projectRows = Object.entries(stats.byProject)
    .sort((a, b) => b[1].cost - a[1].cost)
    .map(([project, data]) => `
      <tr>
        <td>${project}</td>
        <td>${data.count}</td>
        <td>${data.tokens.toLocaleString()}</td>
        <td>$${data.cost.toFixed(2)}</td>
        <td>${(data.tokens / data.count).toFixed(0)}</td>
      </tr>
    `).join('');

  const taskRows = Object.entries(stats.byTask)
    .sort((a, b) => b[1].cost - a[1].cost)
    .slice(0, 15)
    .map(([task, data]) => `
      <tr>
        <td>${task}</td>
        <td>${data.projects.join(', ')}</td>
        <td>${data.count}</td>
        <td>${data.tokens.toLocaleString()}</td>
        <td>$${data.cost.toFixed(2)}</td>
      </tr>
    `).join('');

  const dateRows = Object.entries(stats.byDate)
    .sort((a, b) => b[0].localeCompare(a[0]))
    .slice(0, 30)
    .map(([date, data]) => `
      <tr>
        <td>${date}</td>
        <td>${data.count}</td>
        <td>${data.tokens.toLocaleString()}</td>
        <td>$${data.cost.toFixed(2)}</td>
      </tr>
    `).join('');

  const recentLogs = logs
    .sort((a, b) => b.datetime.localeCompare(a.datetime))
    .slice(0, 20)
    .map(log => `
      <tr>
        <td>${log.datetime}</td>
        <td>${log.project}</td>
        <td>${log.task}</td>
        <td>${log.tokens.toLocaleString()}</td>
        <td>$${log.cost.toFixed(2)}</td>
      </tr>
    `).join('');

  return `
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Claude Token Cost Dashboard</title>
  <style>
    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
      max-width: 1400px;
      margin: 0 auto;
      padding: 20px;
      background: #f5f5f5;
      color: #333;
    }
    h1 {
      color: #000;
      border-bottom: 3px solid #007AFF;
      padding-bottom: 10px;
    }
    h2 {
      color: #555;
      margin-top: 30px;
      font-size: 1.1em;
    }
    .summary {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
      gap: 15px;
      margin: 20px 0;
    }
    .card {
      background: white;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 1px 3px rgba(0,0,0,0.1);
      border-left: 4px solid #007AFF;
    }
    .card h3 {
      margin: 0 0 10px 0;
      color: #666;
      font-size: 0.9em;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }
    .card .value {
      font-size: 1.8em;
      font-weight: bold;
      color: #000;
    }
    .card.cost { border-left-color: #34C759; }
    .card.tokens { border-left-color: #007AFF; }
    .card.tasks { border-left-color: #FF9500; }
    table {
      width: 100%;
      border-collapse: collapse;
      background: white;
      margin: 15px 0;
      border-radius: 8px;
      overflow: hidden;
      box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    }
    th {
      background: #f9f9f9;
      padding: 12px;
      text-align: left;
      font-weight: 600;
      color: #555;
      border-bottom: 1px solid #e0e0e0;
      font-size: 0.9em;
    }
    td {
      padding: 12px;
      border-bottom: 1px solid #f0f0f0;
    }
    tr:hover {
      background: #f9f9f9;
    }
    tr:last-child td {
      border-bottom: none;
    }
    .grid {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 20px;
      margin: 20px 0;
    }
    .note {
      background: #fff3cd;
      border: 1px solid #ffc107;
      padding: 15px;
      border-radius: 4px;
      margin: 15px 0;
    }
    .note strong {
      color: #856404;
    }
    @media (max-width: 768px) {
      .grid { grid-template-columns: 1fr; }
      .summary { grid-template-columns: 1fr; }
    }
  </style>
</head>
<body>
  <h1>🤖 Claude Token Cost Dashboard</h1>

  <div class="summary">
    <div class="card cost">
      <h3>Total Cost</h3>
      <div class="value">$${stats.totalCost.toFixed(2)}</div>
    </div>
    <div class="card tokens">
      <h3>Total Tokens</h3>
      <div class="value">${stats.totalTokens.toLocaleString()}</div>
    </div>
    <div class="card tasks">
      <h3>Tasks Logged</h3>
      <div class="value">${stats.logs}</div>
    </div>
    <div class="card">
      <h3>Avg Cost / Task</h3>
      <div class="value">$${(stats.totalCost / stats.logs).toFixed(3)}</div>
    </div>
  </div>

  <div class="note">
    <strong>💡 Tip:</strong> Log your token usage with: <code>token-tracker.sh log &lt;project&gt; &lt;task&gt; &lt;tokens&gt;</code>
  </div>

  <h2>📊 Costs by Project</h2>
  <table>
    <thead>
      <tr>
        <th>Project</th>
        <th>Tasks</th>
        <th>Tokens</th>
        <th>Cost</th>
        <th>Avg/Task</th>
      </tr>
    </thead>
    <tbody>
      ${projectRows || '<tr><td colspan="5" style="text-align: center; color: #999;">No data yet</td></tr>'}
    </tbody>
  </table>

  <div class="grid">
    <div>
      <h2>🎯 Top Tasks by Cost</h2>
      <table>
        <thead>
          <tr>
            <th>Task</th>
            <th>Projects</th>
            <th>Count</th>
            <th>Tokens</th>
            <th>Cost</th>
          </tr>
        </thead>
        <tbody>
          ${taskRows || '<tr><td colspan="5" style="text-align: center; color: #999;">No data yet</td></tr>'}
        </tbody>
      </table>
    </div>

    <div>
      <h2>📅 Costs by Date</h2>
      <table>
        <thead>
          <tr>
            <th>Date</th>
            <th>Tasks</th>
            <th>Tokens</th>
            <th>Cost</th>
          </tr>
        </thead>
        <tbody>
          ${dateRows || '<tr><td colspan="4" style="text-align: center; color: #999;">No data yet</td></tr>'}
        </tbody>
      </table>
    </div>
  </div>

  <h2>📝 Recent Activity</h2>
  <table>
    <thead>
      <tr>
        <th>Time</th>
        <th>Project</th>
        <th>Task</th>
        <th>Tokens</th>
        <th>Cost</th>
      </tr>
    </thead>
    <tbody>
      ${recentLogs || '<tr><td colspan="5" style="text-align: center; color: #999;">No data yet</td></tr>'}
    </tbody>
  </table>

  <div style="margin-top: 40px; padding-top: 20px; border-top: 1px solid #e0e0e0; color: #999; font-size: 0.9em;">
    <p>Dashboard auto-refreshes every 30 seconds. Data source: ~/.claude/token-usage.log</p>
  </div>

  <script>
    // Auto-refresh every 30 seconds
    setTimeout(() => { location.reload(); }, 30000);
  </script>
</body>
</html>
  `;
}

// Create HTTP server
const server = http.createServer((req, res) => {
  const parsedUrl = url.parse(req.url, true);
  const pathname = parsedUrl.pathname;

  // CORS headers
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, OPTIONS');

  if (pathname === '/api/stats') {
    const logs = parseTokenLog();
    const stats = calculateStats(logs);
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify(stats, null, 2));
  } else if (pathname === '/api/logs') {
    const logs = parseTokenLog();
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify(logs, null, 2));
  } else if (pathname === '/api/projects') {
    const logs = parseTokenLog();
    const projects = [...new Set(logs.map(l => l.project))];
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify(projects, null, 2));
  } else {
    // Serve dashboard HTML
    const logs = parseTokenLog();
    const stats = calculateStats(logs);
    const html = generateHTML(stats, logs);
    res.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8' });
    res.end(html);
  }
});

server.listen(PORT, () => {
  console.log(`
✅ Cost Tracking Dashboard running!

📊 Open: http://localhost:${PORT}
📡 API:  http://localhost:${PORT}/api/stats
📝 Logs: http://localhost:${PORT}/api/logs

📌 Log token usage with:
   token-tracker.sh log <project> <task> <tokens>

Example:
   token-tracker.sh log calm-ai-pm "Add AGENTS.md" 3500
   token-tracker.sh log qa-automation "Fix flaky test" 2800

Press Ctrl+C to stop.
  `);
});
