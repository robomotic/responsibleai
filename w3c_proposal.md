# W3C Community Group Proposal: AI Training Permissions Extension (ATPE)

**Date:** April 19, 2025  
**Authors:** Responsible AI Dataset Initiative  
**Status:** Draft Proposal  

## Abstract

This document proposes a standardized extension to the robots.txt protocol called the AI Training Permissions Extension (ATPE). The extension enables website owners to explicitly declare their preferences regarding the use of their content for artificial intelligence training purposes. The proposal addresses a critical gap in the current web infrastructure, where no standardized mechanism exists for content creators to express consent for AI training use of their work.

## 1. Introduction

### 1.1 Background

Since its informal introduction in 1994, the robots.txt protocol has served as the de facto standard for website owners to communicate with web crawlers about which parts of their sites should or should not be indexed. However, the modern web ecosystem faces new challenges with the rise of large-scale AI models trained on web content.

While the original robots.txt protocol addresses indexing and caching of web content, it lacks the expressiveness needed for the nuanced permissions required for AI training data collection. Current AI training datasets often include web content without explicit permission from creators, leading to legal challenges, copyright disputes, and ethical concerns.

### 1.2 Problem Statement

The current robots.txt protocol has several limitations when applied to AI training contexts:

1. **Binary Permission Model**: It only allows for allowing or disallowing access, without nuance for different types of use.
2. **No Content Type Specificity**: Cannot distinguish permissions between text, images, audio, or video.
3. **No Commercial vs. Non-commercial Distinction**: Cannot express different permissions based on intended use.
4. **No Attribution or Compensation Requirements**: Cannot express conditions for content use.
5. **No Temporal Constraints**: Cannot specify time limits on permissions.

### 1.3 Goals

This proposal aims to:

1. Extend robots.txt with a standardized syntax for AI training permissions
2. Provide granular control to website owners over how their content is used
3. Enable clear expression of attribution and compensation requirements
4. Establish a technical foundation for responsible AI data collection
5. Reduce legal uncertainties for both content creators and AI developers

## 2. Proposed Standard: AI Training Permissions Extension

### 2.1 Overview

The AI Training Permissions Extension (ATPE) builds upon the existing robots.txt protocol to add directives specifically for AI training crawlers and data collection. It uses a similar syntax but introduces new directives with the prefix "AI-Training-".

### 2.2 Core Directives

#### Basic Permission Directive

```
AI-Training: [allowed|conditional|disallowed]
```

This directive indicates the general permission status for AI training use.

#### Content Type Directives

```
AI-Training-Allow-Text: [true|false]
AI-Training-Allow-Images: [true|false]
AI-Training-Allow-Audio: [true|false]
AI-Training-Allow-Video: [true|false]
```

These directives specify permissions for different content types.

#### Usage Scope Directives

```
AI-Training-Commercial-Training: [allowed|disallowed]
AI-Training-NonCommercial-Training: [allowed|disallowed]
```

These directives distinguish between commercial and non-commercial AI training use.

#### Attribution Requirements

```
AI-Training-Attribution-Required: [true|false]
AI-Training-Domain-Credit-Format: "Content from example.com"
AI-Training-Creator-Name: "Author Name"
```

These directives specify attribution requirements for content use.

#### Compensation Requirements

```
AI-Training-Compensation-Required: [true|false]
AI-Training-Compensation-Contact: "licensing@example.com"
AI-Training-Compensation-Link: "https://example.com/ai-licensing"
```

These directives indicate if compensation is required and how to arrange it.

#### Time Constraints

```
AI-Training-Valid-From: YYYY-MM-DD
AI-Training-Valid-Until: YYYY-MM-DD
AI-Training-Max-Snapshot-Age: [days]
```

These directives specify temporal constraints on permissions.

#### Metadata Requirements

```
AI-Training-Require-Source-Tracking: [true|false]
AI-Training-Require-Usage-Notification: [true|false]
AI-Training-Usage-Contact: "aiusage@example.com"
```

These directives specify additional metadata and notification requirements.

### 2.3 Extended Functionality

#### Verification Mechanism

To enhance trust in the permission declarations, we propose a verification mechanism:

```
AI-Training-Version: [version]
AI-Training-Policy-ID: [unique identifier]
AI-Training-Verification-Endpoint: [URL]
AI-Training-Signature: [cryptographic signature]
```

These directives provide a way to cryptographically verify the authenticity of permission declarations.

#### Path-Specific Permissions

ATPE works in conjunction with the standard User-agent, Allow, and Disallow directives to enable path-specific permissions:

```
User-agent: AI-Training-Crawler
Allow: /blog/
Disallow: /private/

AI-Training: allowed
AI-Training-Content-Types: text,images
AI-Training-Commercial-Training: disallowed
```

This allows website owners to specify different permissions for different parts of their site.

## 3. Examples

### 3.1 Basic Implementation

```
User-agent: AI-Training-Crawler
Allow: /blog/
Disallow: /private/

AI-Training: allowed
AI-Training-Content-Types: text
AI-Training-Attribution-Required: true
AI-Training-Domain-Credit-Format: "Content from example.com"
```

### 3.2 Comprehensive Implementation

```
User-agent: AI-Training-Crawler
Allow: /blog/
Allow: /articles/
Disallow: /private/
Disallow: /premium/

AI-Training: conditional
AI-Training-Content-Types: text,images
AI-Training-Commercial-Training: disallowed
AI-Training-NonCommercial-Training: allowed
AI-Training-Attribution-Required: true
AI-Training-Domain-Credit-Format: "Content from example.com"
AI-Training-Creator-Name: "Example Team"
AI-Training-Valid-From: 2025-01-01
AI-Training-Valid-Until: 2026-01-01
AI-Training-Max-Snapshot-Age: 90
AI-Training-Require-Source-Tracking: true
AI-Training-Require-Usage-Notification: true
AI-Training-Usage-Contact: "aiusage@example.com"
AI-Training-Version: 1.0
AI-Training-Policy-ID: 5f2c8a9b-3e1d-4ef2-b4c1-7a539a25f0d2
```

## 4. Implementation Considerations

### 4.1 Backward Compatibility

The ATPE is designed to be backward compatible with existing robots.txt implementations:

1. The standard User-agent, Allow, and Disallow directives continue to function as before.
2. Crawlers that do not recognize ATPE directives can ignore them.
3. AI training crawlers that recognize ATPE should respect both standard directives and ATPE directives.

### 4.2 Precedence Rules

When interpreting ATPE directives, implementers should follow these precedence rules:

1. Specific directives override general directives.
2. Path-specific permissions override domain-level permissions.
3. Newer declarations (based on timestamps) override older declarations.
4. If a directive is not specified, it should not be assumed to be either permitted or restricted.

### 4.3 Alternative Implementation Methods

While robots.txt is the primary implementation method for ATPE, we recognize that alternative methods may be appropriate in certain contexts. The ATPE specification can also be implemented through:

1. **HTTP Headers**:
   ```
   AI-Training-Allowed: true
   AI-Training-Content-Types: text
   AI-Training-Attribution-Required: true
   ```

2. **HTML Meta Tags**:
   ```html
   <meta name="ai-training" content="allowed">
   <meta name="ai-training-content-types" content="text,images">
   <meta name="ai-training-attribution" content="required">
   ```

3. **Structured Data (JSON-LD)**:
   ```json
   {
     "@context": "https://schema.org",
     "@type": "WebPage",
     "aiTrainingPermission": {
       "@type": "AITrainingPermission",
       "permissionStatus": "allowed",
       "contentTypes": ["text", "images"],
       "attributionRequired": true
     }
   }
   ```

These alternative methods should use the same directive names and values as the robots.txt implementation.

## 5. Security and Privacy Considerations

### 5.1 Integrity Protection

To prevent tampering with permission declarations, the specification includes cryptographic signature options. Implementers should:

1. Generate a cryptographic key pair for signing permissions.
2. Sign the permission declaration with the private key.
3. Include the signature and public key identifier in the declaration.
4. Verify signatures before relying on permission declarations.

### 5.2 Validation Endpoint

The AI-Training-Verification-Endpoint directive allows website owners to provide a URL that can be queried to verify permissions, enabling real-time validation and revocation capabilities.

### 5.3 Privacy Implications

Implementers should consider that permission declarations may reveal information about a website's content strategy and business model. The specification intentionally avoids requiring personal information in declarations.

## 6. Benefits and Ecosystem Impact

### 6.1 For Website Owners

1. **Granular Control**: Express nuanced permissions for different content types and uses.
2. **Attribution Protection**: Ensure proper credit for content contributions to AI systems.
3. **Compensation Framework**: Create a technical foundation for fair value exchange.
4. **Legal Standing**: Strengthen position in legal disputes over content use.

### 6.2 For AI Developers

1. **Clear Permissions**: Reduce legal uncertainty about content use.
2. **Ethical Development**: Build systems with properly permissioned data.
3. **Verifiable Compliance**: Demonstrate adherence to creator preferences.
4. **Risk Reduction**: Mitigate potential legal challenges.

### 6.3 For the Web Ecosystem

1. **Reduced Friction**: Clear permission framework reduces conflicts.
2. **Enhanced Transparency**: Explicit permissions create a more transparent ecosystem.
3. **Sustainable Model**: Framework for fair value exchange between creators and AI developers.
4. **Innovation Support**: Enables responsible AI advancement while respecting creator rights.

## 7. Adoption Strategy

### 7.1 Technical Implementation

1. **Parser Libraries**: Develop open-source libraries for parsing ATPE in major programming languages.
2. **Crawler Integration**: Work with major crawlers to implement ATPE recognition.
3. **Verification Tools**: Create tools for validating ATPE implementations.
4. **CMS Plugins**: Develop plugins for popular content management systems.

### 7.2 Community Building

1. **Educational Resources**: Create documentation and guides for website owners.
2. **Developer Tools**: Build tools to simplify implementation for developers.
3. **Implementation Registry**: Establish a registry of organizations honoring ATPE.
4. **Compliance Badging**: Develop a certification program for compliant systems.

## 8. Conclusion

The AI Training Permissions Extension addresses a critical gap in the current web infrastructure by providing a standardized way for website owners to express their preferences regarding AI training use of their content. By building upon the familiar robots.txt protocol, ATPE offers an accessible, backward-compatible solution that can be widely adopted.

We propose that the W3C establish a Community Group to further develop this specification, with the goal of eventual standardization. The widespread adoption of ATPE would benefit content creators, AI developers, and the web ecosystem as a whole by creating a framework for responsible AI training data collection.

## 9. References

1. Robots Exclusion Protocol (REP) - https://datatracker.ietf.org/doc/html/draft-koster-rep
2. The Responsible AI Dataset Initiative Manifesto
3. OECD AI Principles - https://oecd.ai/en/ai-principles
4. EU AI Act - https://artificialintelligenceact.eu/the-act/
5. UK Copyright and Artificial Intelligence Consultation - https://www.gov.uk/government/consultations/copyright-and-artificial-intelligence

## 10. Acknowledgments

We acknowledge the contributions of the Responsible AI Dataset Initiative members and the broader web community in developing this proposal.

## 11. Appendix: Grammar Specification

```abnf
; ATPE Grammar in ABNF notation

robots-txt = *(group / comment / AI-training-directive)

group = user-agent *(allow / disallow)

user-agent = "User-agent:" SP user-agent-value CRLF
user-agent-value = product / "*"
product = 1*CHAR

allow = "Allow:" SP [path] CRLF
disallow = "Disallow:" SP [path] CRLF
path = "/" *CHAR

comment = "#" *(VCHAR / SP) CRLF

AI-training-directive = AI-training-basic / AI-content-type / AI-usage-scope / 
                        AI-attribution / AI-compensation / AI-time / AI-metadata /
                        AI-verification

AI-training-basic = "AI-Training:" SP ("allowed" / "conditional" / "disallowed") CRLF

AI-content-type = ("AI-Training-Allow-Text:" / "AI-Training-Allow-Images:" /
                  "AI-Training-Allow-Audio:" / "AI-Training-Allow-Video:") SP
                  ("true" / "false") CRLF

AI-usage-scope = ("AI-Training-Commercial-Training:" / "AI-Training-NonCommercial-Training:") SP
                ("allowed" / "disallowed") CRLF

AI-attribution = ("AI-Training-Attribution-Required:" SP ("true" / "false") CRLF) /
                ("AI-Training-Domain-Credit-Format:" SP quoted-string CRLF) /
                ("AI-Training-Creator-Name:" SP quoted-string CRLF)

AI-compensation = ("AI-Training-Compensation-Required:" SP ("true" / "false") CRLF) /
                 ("AI-Training-Compensation-Contact:" SP quoted-string CRLF) /
                 ("AI-Training-Compensation-Link:" SP uri CRLF)

AI-time = ("AI-Training-Valid-From:" SP date CRLF) /
         ("AI-Training-Valid-Until:" SP date CRLF) /
         ("AI-Training-Max-Snapshot-Age:" SP 1*DIGIT CRLF)

AI-metadata = ("AI-Training-Require-Source-Tracking:" SP ("true" / "false") CRLF) /
             ("AI-Training-Require-Usage-Notification:" SP ("true" / "false") CRLF) /
             ("AI-Training-Usage-Contact:" SP quoted-string CRLF)

AI-verification = ("AI-Training-Version:" SP 1*DIGIT "." 1*DIGIT CRLF) /
                 ("AI-Training-Policy-ID:" SP 1*VCHAR CRLF) /
                 ("AI-Training-Verification-Endpoint:" SP uri CRLF) /
                 ("AI-Training-Signature:" SP signature-method ":" signature-value CRLF)

signature-method = "ed25519" / "ecdsa-p256" / token
signature-value = 1*VCHAR

quoted-string = DQUOTE *CHAR DQUOTE
uri = scheme ":" hier-part [ "?" query ] [ "#" fragment ]
date = 4DIGIT "-" 2DIGIT "-" 2DIGIT
token = 1*tchar
tchar = "!" / "#" / "$" / "%" / "&" / "'" / "*" / "+" / "-" / "." /
       "^" / "_" / "`" / "|" / "~" / DIGIT / ALPHA
```