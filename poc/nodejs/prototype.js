const axios = require('axios');
const fs = require('fs');
const { URL } = require('url');

const USER_AGENT = 'AI-Training-Crawler';

async function fetchRobotsTxt(url) {
  const parsed = new URL(url);
  const robotsUrl = `${parsed.protocol}//${parsed.host}/robots.txt`;
  try {
    const resp = await axios.get(robotsUrl, { timeout: 5000 });
    return resp.data;
  } catch {
    return '';
  }
}

function parseAiTrainingDirectives(robotsTxt) {
  const directives = {};
  robotsTxt.split(/\r?\n/).forEach(line => {
    if (line.startsWith('AI-Training') || line.startsWith('User-agent')) {
      const [key, ...rest] = line.split(':');
      directives[key.trim()] = rest.join(':').trim();
    }
  });
  return directives;
}

function isPathAllowed(directives, path) {
  const ua = directives['User-agent'] || '';
  if (ua !== USER_AGENT) return false;
  const allow = directives['Allow'] || '';
  const disallow = directives['Disallow'] || '';
  if (disallow && path.startsWith(disallow)) return false;
  if (allow && path.startsWith(allow)) return true;
  return false;
}

function storeProvenance(url, allowed, directives) {
  const record = {
    url,
    checked_at: new Date().toISOString(),
    allowed,
    directives
  };
  fs.appendFileSync('provenance.json', JSON.stringify(record) + '\n');
}

(async () => {
  const testUrl = process.argv[2] || 'http://127.0.0.1:5000/blog/article1';
  const robotsTxt = await fetchRobotsTxt(testUrl);
  const directives = parseAiTrainingDirectives(robotsTxt);
  const path = new URL(testUrl).pathname;
  const allowed = isPathAllowed(directives, path);
  console.log(`AI-Training permission for ${testUrl}: ${allowed}`);
  storeProvenance(testUrl, allowed, directives);
})();
