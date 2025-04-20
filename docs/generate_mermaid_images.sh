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

# Core Principle 1: Copyright Respect and Fair Compensation
echo "Generating diagram for Core Principle 1: Copyright Respect and Fair Compensation"
cat > copyright_fair_compensation.mmd <<'EOF'
graph TD
  A[Copyright Respect and Fair Compensation]
  subgraph Key Aspects
    B[Explicit Permission]
    C[Fair Compensation]
    D[Opt-in by Default]
    E[Licensing Clarity]
  end
  A --> B
  A --> C
  A --> D
  A --> E
EOF

# Core Principle 2: Transparency and Documentation
echo "Generating diagram for Core Principle 2: Transparency and Documentation"
cat > transparency_documentation.mmd <<'EOF'
graph TD
  A[Transparency and Documentation]
  subgraph Key Aspects
    B[Complete Provenance Tracking]
    C[Content Labeling]
    D[Processing Transparency]
    E[Bias Documentation]
  end
  A --> B
  A --> C
  A --> D
  A --> E
EOF

# Core Principle 3: Ethical Data Selection
echo "Generating diagram for Core Principle 3: Ethical Data Selection"
cat > ethical_data_selection.mmd <<'EOF'
graph TD
  A[Ethical Data Selection]
  subgraph Key Aspects
    B[Exclusion of Harmful Content]
    C[Representational Fairness]
    D[Respect for Privacy]
    E[Cultural Sensitivity]
  end
  A --> B
  A --> C
  A --> D
  A --> E
EOF

# Core Principle 4: Governance and Oversight
echo "Generating diagram for Core Principle 4: Governance and Oversight"
cat > governance_oversight.mmd <<'EOF'
graph TD
  A[Governance and Oversight]
  subgraph Key Aspects
    B[Independent Ethics Board]
    C[Regular Audits]
    D[Stakeholder Inclusion]
    E[Responsiveness to Concerns]
  end
  A --> B
  A --> C
  A --> D
  A --> E
EOF

# Core Principle 5: Technical Implementation
echo "Generating diagram for Core Principle 5: Technical Implementation"
cat > technical_implementation.mmd <<'EOF'
graph TD
  A[Technical Implementation]
  subgraph Key Aspects
    B[Open Metadata Standards]
    C[Verifiable Compliance]
    D[Flexible Subsetting]
    E[Continuous Improvement]
  end
  A --> B
  A --> C
  A --> D
  A --> E
EOF

# Generate PNGs
mmdc -i permission_flow.mmd -o permission_flow.png
mmdc -i ecosystem_relationships.mmd -o ecosystem_relationships.png
mmdc -i copyright_fair_compensation.mmd       -o copyright_fair_compensation.png
mmdc -i transparency_documentation.mmd        -o transparency_documentation.png
mmdc -i ethical_data_selection.mmd            -o ethical_data_selection.png
mmdc -i governance_oversight.mmd              -o governance_oversight.png
mmdc -i technical_implementation.mmd           -o technical_implementation.png

echo "Diagrams generated: permission_flow.png, ecosystem_relationships.png, copyright_fair_compensation.png, transparency_documentation.png, ethical_data_selection.png, governance_oversight.png, technical_implementation.png"
