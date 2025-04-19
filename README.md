# Responsible AI Dataset Initiative

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Issues](https://img.shields.io/github/issues/robomotic/responsibleai)](https://github.com/robomotic/responsibleai/issues)
[![Pull Requests](https://img.shields.io/github/issues-pr/robomotic/responsibleai)](https://github.com/robomotic/responsibleai/pulls)
[![Last Commit](https://img.shields.io/github/last-commit/robomotic/responsibleai)](https://github.com/robomotic/responsibleai/commits/main)

## Vision
To establish the world's first comprehensively ethical, transparent, and legally compliant dataset of internet content (text, audio, and video) specifically designed for training open-source transformer models, ensuring that artificial intelligence development respects creator rights, promotes transparency, and upholds human values.

## Problem Statement
Current approaches to AI training data collection often:
- Use copyrighted materials without proper authorization or attribution
- Lack transparency about data provenance and processing methods
- Fail to obtain appropriate consent from content creators
- Ignore cultural, ethical, and legal boundaries across jurisdictions
- Create legal uncertainties that hamper legitimate innovation

## Core Principles

### 1. Copyright Respect and Fair Compensation
- **Explicit Permission**: We will only include content where we have explicit permission from copyright holders
- **Fair Compensation**: Develop sustainable compensation models for creators whose work is included
- **Opt-in by Default**: No content will be included without affirmative consent
- **Licensing Clarity**: All content will have clear, transparent licensing terms

### 2. Transparency and Documentation
- **Complete Provenance Tracking**: Full documentation of content origin, permissions obtained, and processing methodologies
- **Content Labeling**: Clear labeling of all dataset components including source, date collected, and modification history
- **Processing Transparency**: Open documentation of cleaning, normalization, and processing techniques
- **Bias Documentation**: Honest assessment and documentation of potential biases in the dataset

### 3. Ethical Data Selection
- **Exclusion of Harmful Content**: Rigorous screening to exclude content promoting hate speech, discrimination, or illegal activities
- **Representational Fairness**: Active curation to ensure diverse perspectives and reduce harmful biases
- **Respect for Privacy**: Exclusion of sensitive personal information and strict compliance with privacy regulations
- **Cultural Sensitivity**: Recognition and respect for differing cultural norms and values

### 4. Governance and Oversight
- **Independent Ethics Board**: Establishment of a diverse oversight committee to review data collection practices
- **Regular Audits**: Periodic independent audits of the dataset and collection practices
- **Stakeholder Inclusion**: Involvement of creators, legal experts, ethicists, and diverse community representatives in governance
- **Responsiveness to Concerns**: Clear mechanisms for addressing concerns raised about specific content

### 5. Technical Implementation
- **Open Metadata Standards**: Development of standardized metadata formats for tracking permissions and provenance
- **Verifiable Compliance**: Technical mechanisms to verify and validate compliance with stated principles
- **Flexible Subsetting**: Tools to allow dataset users to filter content based on specific ethical or legal requirements
- **Continuous Improvement**: Commitment to ongoing refinement of standards and practices

## Legal Framework Integration

### OECD AI Principles Alignment
Our initiative explicitly incorporates the OECD AI Principles, ensuring AI systems are:
- Designed to respect human rights, democratic values, and diversity
- Transparent and responsible in disclosure
- Robust, secure, and safe throughout their lifecycle
- Accountable with clear attribution of responsibility

### EU AI Act Compliance
We commit to:
- Adhering to the risk-based approach of the EU AI Act
- Providing comprehensive documentation meeting transparency requirements
- Ensuring data quality governance as specified in Article 10
- Supporting AI system providers in their compliance efforts

### UK AI Safety Considerations
In alignment with the UK AI Safety Institute's focus areas:
- We prioritize methodologies that reduce risks of frontier AI capabilities
- We adopt evaluation frameworks that assess safety at all stages
- We incorporate safety metrics in dataset design and documentation

### Copyright Law Respect
Drawing from international copyright principles and national frameworks:
- Respect for exclusive rights of authors and creators
- Proper attribution and licensing
- Fair remuneration for rightsholders
- Specific attention to UK copyright consultation findings regarding AI training

## Enhanced Robots.txt Protocol for AI Training

The traditional robots.txt protocol has been the web's standard for crawler permissions since 1994 but lacks the granularity needed for AI training use cases. We propose an extended standard that enables website owners to explicitly indicate their preferences regarding AI training use of their content.

### Current Limitations of robots.txt
- Limited to basic crawl permissions without content usage specifications
- No distinction between crawling for indexing versus training data collection
- No mechanisms for compensation agreements or attribution requirements
- No granular control over which parts of content may be used for training
- No versioning or time-bound permissions

### Proposed AI Training Permissions Extension (ATPE)

We will develop and advocate for a standardized extension to robots.txt that includes:

#### 1. AI-Specific User-Agent Directives
```
User-agent: AI-Training-Crawler
Allow: /blog/
Disallow: /personal/
```

#### 2. Training-Specific Permission Directives
```
AI-Training: allowed
AI-Commercial-Training: disallowed
AI-NonCommercial-Training: allowed
AI-Attribution-Required: true
AI-Domain-Credit-Format: "Content from example.com"
```

#### 3. Content Type Specifications
```
AI-Training-Allow-Text: true
AI-Training-Allow-Images: false
AI-Training-Allow-Audio: false
AI-Training-Allow-Video: false
```

#### 4. Compensation and Licensing Terms
```
AI-Training-License: Creative-Commons-BY
AI-Training-Compensation-Required: true
AI-Training-Compensation-Contact: licensing@example.com
AI-Training-Compensation-Link: https://example.com/ai-licensing
```

#### 5. Time and Version Constraints
```
AI-Training-Valid-From: 2025-04-01
AI-Training-Valid-Until: 2026-04-01
AI-Training-Max-Snapshot-Age: 90
```

#### 6. Metadata Requirements
```
AI-Training-Require-Source-Tracking: true
AI-Training-Require-Usage-Notification: true
AI-Training-Usage-Contact: aiusage@example.com
```

### Implementation Strategy

1. **Developer Tools**: Create open-source parser libraries for the new protocol in multiple languages
2. **Website Owner Tools**: Develop user-friendly generators for creating appropriate directives
3. **Centralized Registry**: Establish a public registry of organizations honoring the extended protocol
4. **Compliance Verification**: Build tools for website owners to verify adherence to their directives
5. **Standardization**: Work with W3C and other standards bodies to formalize the extension

### Education and Adoption Plan

1. **Documentation**: Comprehensive guides for website owners, developers, and AI researchers
2. **Plugin Ecosystem**: Create plugins for popular CMS platforms (WordPress, Drupal, etc.)
3. **Public Campaign**: Raise awareness among content creators about the new control options
4. **Compliance Badging**: Develop a certification program for AI projects respecting these directives
5. **Policy Advocacy**: Work with regulators to recognize this standard as evidence of good practice

### Benefits of the Enhanced Protocol

For website owners:
- Granular control over content usage without requiring legal expertise
- Ability to distinguish between different AI use cases
- Technical mechanism to establish compensation expectations
- Simple implementation through familiar technology

For AI developers:
- Clear permissions reduce legal risks
- Standardized approach to permission management
- Automated compliance verification
- Ethical data collection at scale

For the ecosystem:
- Reduced friction between content creators and AI innovation
- Transparent permission tracking
- Greater certainty about appropriate usage
- Balanced approach to enabling innovation while protecting rights

### Technical Example: Implementation Flowchart

1. AI training crawler encounters a website
2. Checks for enhanced robots.txt directives
3. If present, records all permissions metadata 
4. Honors all restrictions during crawling process
5. Maintains complete provenance record in dataset
6. Implements compensation/notification if specified
7. Provides verification evidence to website owner

### Technical Implementation Considerations

1. **HTTP Headers Integration** – In addition to robots.txt, the protocol can be implemented via HTTP headers to provide per-response permissions for dynamic content or API responses. This allows for more granular, real-time control and is especially useful for sites with frequently changing or user-generated content.

2. **Digital Signatures** – Incorporating cryptographic signatures into permission declarations ensures that permissions cannot be tampered with and provides verifiable proof for compliance auditing. This enables both dataset creators and website owners to demonstrate that permissions were properly granted and respected.

3. **Machine-Readable Terms Registry** – Establishing a centralized registry of standardized licensing and permission terms (similar to Creative Commons) would make it easier for crawlers and dataset builders to automatically process, interpret, and respect complex terms. This registry could be referenced in robots.txt or HTTP headers for clarity and interoperability.

### Regulatory Alignment

This approach directly addresses several regulatory requirements:

- **EU AI Act Article 10**: Satisfies requirements for "adequate data governance" by providing an auditable, transparent permission system for AI training data.
- **UK's proposed copyright framework**: Empowers creators with direct, technical control over AI training usage of their content.
- **Potential US regulations**: Establishes a clear opt-in mechanism compatible with emerging state and federal laws regarding data use and AI.

### Initial Proof of Concept

A practical first step toward adoption would be to create a reference implementation consisting of:

1. **AI Training Crawler**: A crawler that understands and respects the extended robots.txt and HTTP header directives, only collecting data with explicit permission.
2. **Dashboard for Website Owners**: A simple web-based tool for website owners to generate, validate, and manage their robots.txt extensions and HTTP header permissions.
3. **Verification Tool**: A public tool or service that shows which sites have granted what permissions, enabling transparency and trust in the ecosystem.
4. **Consortium of Early Adopters**: Recruit a small group of initial adopters (publishers, bloggers, academic institutions) to pilot the protocol and provide feedback for improvement.

This proof of concept would demonstrate the feasibility and value of permission-based AI training, while building the technical and social infrastructure needed for broader adoption.

## Implementation Roadmap

### Phase 1: Framework Development
- Establish detailed guidelines for data collection and permission-seeking
- Develop technical infrastructure for permission tracking and content documentation
- Create governance structure and ethical oversight committee

### Phase 2: Pilot Collection
- Begin small-scale content collection with focused partnerships
- Test permission and compensation models with willing creators
- Refine processes based on initial learnings

### Phase 3: Scaling
- Expand collection across diverse content types and domains
- Build creator-friendly tools for permission management
- Develop transparency tools for public exploration of dataset composition

### Phase 4: Community Ecosystem
- Enable third-party auditing and evaluation
- Support research on ethical dataset development
- Share learnings and best practices with the broader AI community

## Call to Action

We invite:
- **Content Creators**: Join us in defining fair terms for AI training use of your work
- **AI Researchers**: Help develop and adopt ethical standards for training data
- **Legal Experts**: Contribute to creating clear frameworks that respect copyright while enabling innovation
- **Ethicists**: Guide our approach to representing diverse values and perspectives
- **Policymakers**: Collaborate on regulatory frameworks that protect rights while enabling responsible advancement

## Conclusion

The future of artificial intelligence depends on its foundations. By establishing this pioneering initiative for responsibly sourced training data, we aim to demonstrate that technical innovation and ethical responsibility can advance together, creating AI systems that rightfully respect creator rights, transparently document their foundations, and genuinely serve humanity's diverse needs and values.

---

*This manifesto represents our commitment to establishing a new standard for AI training data that respects legal boundaries, ethical considerations, and creator rights. We believe responsible AI development starts with responsible data practices.*