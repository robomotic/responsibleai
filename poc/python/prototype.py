import requests
import re
import json
from urllib.parse import urlparse

# --- CONFIG ---
USER_AGENT = 'AI-Training-Crawler'

# --- Fetch robots.txt ---
def fetch_robots_txt(url):
    parsed = urlparse(url)
    robots_url = f"{parsed.scheme}://{parsed.netloc}/robots.txt"
    resp = requests.get(robots_url, timeout=5)
    return resp.text if resp.status_code == 200 else ''

# --- Parse AI-Training directives ---
def parse_ai_training_directives(robots_txt):
    directives = {}
    for line in robots_txt.splitlines():
        if line.startswith('AI-Training') or line.startswith('User-agent'):
            key, _, value = line.partition(':')
            directives[key.strip()] = value.strip()
    return directives

# --- Check permission for a path ---
def is_path_allowed(directives, path):
    ua = directives.get('User-agent', '')
    if ua != USER_AGENT:
        return False
    allow = directives.get('Allow', '')
    disallow = directives.get('Disallow', '')
    if disallow and path.startswith(disallow):
        return False
    if allow and path.startswith(allow):
        return True
    return False

# --- Store provenance record ---
def store_provenance(url, allowed, directives):
    record = {
        'url': url,
        'checked_at': __import__('datetime').datetime.utcnow().isoformat() + 'Z',
        'allowed': allowed,
        'directives': directives
    }
    with open('provenance.json', 'a') as f:
        f.write(json.dumps(record) + '\n')

# --- Main ---
if __name__ == '__main__':
    import sys
    test_url = sys.argv[1] if len(sys.argv) > 1 else 'http://127.0.0.1:5000/blog/article1'
    robots_txt = fetch_robots_txt(test_url)
    directives = parse_ai_training_directives(robots_txt)
    path = urlparse(test_url).path
    allowed = is_path_allowed(directives, path)
    print(f"AI-Training permission for {test_url}: {allowed}")
    store_provenance(test_url, allowed, directives)
