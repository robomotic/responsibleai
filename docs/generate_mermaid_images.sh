#!/bin/bash
# Script to generate PNG images from Mermaid diagrams for the Responsible AI Dataset Initiative website
# Requires: Mermaid CLI (mmdc) installed globally via npm

set -e

# Check for mmdc
if ! command -v mmdc &> /dev/null; then
  echo "Error: Mermaid CLI (mmdc) is not installed. Install with: npm install -g @mermaid-js/mermaid-cli"
  exit 1
fi

# Permission Flow Diagram
cat > permission_flow.mmd <<'EOF'
graph TD
  A[AI Training Crawler] -->|Checks| B[robots.txt/HTTP Headers]
  B -->|Parses Permissions| C{Permission Granted?}
  C -- Yes --> D[Collect Content]
  C -- No --> E[Skip Content]
  D --> F[Record Provenance]
  D --> G[Notify/Compensate Creator]
EOF

# Ecosystem Relationships Diagram
cat > ecosystem_relationships.mmd <<'EOF'
graph LR
  WebsiteOwner -- Grants Permissions --> Dataset
  Dataset -- Used By --> AIResearcher
  Dataset -- Audited By --> EthicsBoard
  WebsiteOwner -- Receives Attribution/Compensation --> Dataset
  AIResearcher -- Submits Feedback --> Dataset
EOF

# Generate PNGs
mmdc -i permission_flow.mmd -o permission_flow.png
mmdc -i ecosystem_relationships.mmd -o ecosystem_relationships.png

echo "Diagrams generated: permission_flow.png, ecosystem_relationships.png"
