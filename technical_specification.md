# Technical Specification: Permission Tracking and Content Provenance

*Version: 1.0 - April 19, 2025*

## 1. Introduction

### 1.1 Purpose

This technical specification defines the architecture, data models, and protocols for implementing a comprehensive permission tracking and content provenance system for AI training datasets. The system is designed to address the legal and ethical challenges identified in the Responsible AI Dataset Initiative Manifesto by providing verifiable proof of content authorization and origin.

### 1.2 Key Challenges Addressed

- Verifiable consent management for content used in AI training
- Continuous tracking of content provenance throughout the AI lifecycle
- Technical enforcement of usage restrictions and attribution requirements
- Scalable verification of compliance with creator-defined terms
- Integration with existing web standards and infrastructure

### 1.3 Design Principles

- **Decentralized First**: Minimize central authority requirements while enabling independent verification
- **Standards-Based**: Leverage and extend existing web and data standards where possible
- **Privacy-Preserving**: Implement consent without requiring unnecessary personal data
- **Verifiable**: All claims should be cryptographically verifiable by third parties
- **Extensible**: Allow for future refinements and additional metadata requirements
- **Open**: Fully documented and implemented with open-source components

## 2. System Architecture

### 2.1 High-Level Components

![System Architecture Diagram]

The permission tracking and provenance system consists of these core components:

1. **Permission Declaration Infrastructure**
   - Enhanced robots.txt processor
   - HTTP header extensions parser
   - Structured data extraction (Schema.org, JSON-LD)
   - HTML meta tags processor
   
2. **Content Identification Service**
   - Perceptual hashing system
   - Fingerprinting service
   - Checksum verification
   - Fuzzy matching algorithms
   
3. **Provenance Database**
   - Immutable ledger of permissions and content metadata
   - Versioned history of changes to permissions
   - Queryable audit trail
   
4. **Verification Gateway**
   - Permission validation service
   - Provenance chain inspection
   - Attribution generation
   - Compliance certification
   
5. **Developer Toolkit**
   - Libraries for major programming languages
   - Integration APIs for content management systems
   - Verification tools for model creators

### 2.2 Data Flow Overview

1. **Content Discovery Phase**
   - Web crawler identifies potential content
   - Permission declarations are detected and parsed
   - Initial metadata is extracted
   
2. **Permission Validation Phase**
   - Permission declarations are verified
   - Terms are translated to machine-readable restrictions
   - Authorization decisions are recorded
   
3. **Content Acquisition Phase**
   - Authorized content is obtained
   - Content fingerprints are generated
   - Full metadata package is created
   
4. **Provenance Registration Phase**
   - Permission and content metadata are registered in provenance database
   - Cryptographic proofs are generated
   - Notifications are sent to content owners if requested
   
5. **Dataset Compilation Phase**
   - Content is processed according to permitted uses
   - Metadata is preserved through transformations
   - Usage limitations are encoded as dataset attributes
   
6. **Model Training Phase**
   - Dataset provenance is verified before training
   - Training process records dataset usage
   - Model receives provenance metadata

## 3. Permission Acquisition and Storage

### 3.1 Permission Declaration Methods

#### 3.1.1 Enhanced robots.txt Specification

The system implements the AI Training Permissions Extension (ATPE) as defined in the Manifesto, with these additional technical details:

```
# Standard robots.txt directives
User-agent: AI-Training-Crawler
Allow: /blog/
Disallow: /personal/

# AI Training-specific directives
AI-Training: allowed
AI-Training-Version: 1.0
AI-Training-Policy-ID: 5f2c8a9b-3e1d-4ef2-b4c1-7a539a25f0d2
AI-Training-Verification-Endpoint: https://example.com/.well-known/ai-permissions/verify
AI-Training-Signature: ed25519:a4d1af...[truncated]
```

Additional fields:
- `AI-Training-Version`: Protocol version being used
- `AI-Training-Policy-ID`: Unique identifier for the specific permission policy
- `AI-Training-Verification-Endpoint`: URL that can be queried to verify permissions
- `AI-Training-Signature`: Cryptographic signature of the permissions declaration

#### 3.1.2 HTTP Header Extensions

For dynamic content or API responses:

```
AI-Training-Allowed: true
AI-Training-Policy-ID: 5f2c8a9b-3e1d-4ef2-b4c1-7a539a25f0d2
AI-Training-Content-Types: text
AI-Training-License: CC-BY-4.0
AI-Training-Signature: ed25519:b3f9c7...[truncated]
```

#### 3.1.3 HTML Metadata

For webpage-specific permissions:

```html
<meta name="ai-training" content="allowed">
<meta name="ai-training-policy-id" content="5f2c8a9b-3e1d-4ef2-b4c1-7a539a25f0d2">
<meta name="ai-training-content-types" content="text,images">
<meta name="ai-training-license" content="CC-BY-4.0">
<meta name="ai-training-compensation" content="required">
<meta name="ai-training-signature" content="ed25519:c7e2d8...[truncated]">
```

#### 3.1.4 JSON-LD Schema.org Extension

For structured data embedding:

```json
{
  "@context": "https://schema.org",
  "@type": "WebPage",
  "name": "Article Title",
  "aiTrainingPermission": {
    "@type": "AITrainingPermission",
    "permissionStatus": "allowed",
    "policyId": "5f2c8a9b-3e1d-4ef2-b4c1-7a539a25f0d2",
    "contentTypes": ["text", "images"],
    "license": "CC-BY-4.0",
    "compensationRequired": true,
    "verificationEndpoint": "https://example.com/.well-known/ai-permissions/verify",
    "signature": "ed25519:d9f1e5...[truncated]"
  }
}
```

### 3.2 Permission Data Model

The core permission data model includes:

```json
{
  "permissionId": "string (UUID)",
  "sourceIdentifier": "string (URL, DOI, ISBN, etc.)",
  "permissionType": "enum (Allowed, Conditional, Disallowed)",
  "contentTypes": ["enum (Text, Image, Audio, Video, Dataset)"],
  "usageScopes": ["enum (Training, Inference, Distribution, Commercial, NonCommercial)"],
  "restrictions": {
    "requireAttribution": "boolean",
    "attributionFormat": "string (template)",
    "requireCompensation": "boolean",
    "compensationTerms": "string or URI",
    "maxSnapshotAge": "integer (days)",
    "geographicRestrictions": ["string (ISO country codes)"],
    "contentRestrictions": ["string (content category restrictions)"]
  },
  "licensingTerms": {
    "licenseType": "string (SPDX identifier or URI)",
    "licenseText": "string or URI",
    "validFrom": "dateTime (ISO 8601)",
    "validUntil": "dateTime (ISO 8601)"
  },
  "verificationMetadata": {
    "declarationTimestamp": "dateTime (ISO 8601)",
    "signatureMethod": "string (algorithm identifier)",
    "signature": "string (base64)",
    "verificationEndpoint": "string (URI)",
    "publicKeyId": "string (key identifier or URI)"
  },
  "contactInformation": {
    "contactType": "enum (Technical, Legal, Notification)",
    "contactMethod": "enum (Email, URI)",
    "contactValue": "string"
  }
}
```

### 3.3 Permission Storage

Permissions are stored in a distributed database with these properties:

1. **Immutability**: Once recorded, permissions cannot be altered, only superseded
2. **Versioning**: All changes to permissions are versioned with timestamps
3. **Query Capability**: Efficient lookup by content identifier, domain, or permission attributes
4. **Cryptographic Verification**: All entries contain cryptographic proofs of authenticity
5. **Redundancy**: Multiple storage locations to prevent single points of failure

Implementation options:
- Distributed ledger technology (permissioned blockchain)
- Merkle-tree based append-only logs
- Content-addressed storage with signed manifests

## 4. Content Provenance Tracking

### 4.1 Content Identification

Each piece of content is identified using multiple complementary approaches:

#### 4.1.1 Canonical Identifiers
- URL (including archival version links)
- DOI, ISBN, ISSN, or other standardized identifiers
- Content publisher's internal identifiers (when provided)

#### 4.1.2 Content Integrity Verification
- Cryptographic hashes (SHA-256, SHA-3, BLAKE3)
- Perceptual hashes for media content (pHash, aHash, dHash)
- Robust fingerprinting for fuzzy matching

#### 4.1.3 Chunking and Segment Identification
- Content is divided into logical segments with individual identifiers
- Overlapping chunks to enable fragment verification
- Hierarchical identification for nested content (e.g., articles within collections)

### 4.2 Provenance Metadata Schema

The provenance record for each content piece includes:

```json
{
  "contentId": {
    "canonicalId": "string (URI, DOI, etc.)",
    "contentHashes": [
      {
        "algorithm": "string (hash algorithm)",
        "value": "string (hash value)",
        "scope": "string (full, segment, etc.)"
      }
    ],
    "perceptualFingerprints": [
      {
        "algorithm": "string (fingerprint algorithm)",
        "value": "string (base64 encoded)",
        "scope": "string (media type scope)"
      }
    ]
  },
  "contentMetadata": {
    "title": "string",
    "creator": "string or array",
    "publisher": "string",
    "publicationDate": "dateTime (ISO 8601)",
    "contentType": "string (MIME type)",
    "language": "string (ISO 639)",
    "topics": ["string (subject categories)"],
    "originalFormat": "string (file format)"
  },
  "acquisitionMetadata": {
    "acquisitionMethod": "string (crawl, API, direct submission)",
    "acquisitionDate": "dateTime (ISO 8601)",
    "acquisitionAgent": "string (crawler identifier)",
    "permissionId": "string (reference to permission record)",
    "permissionVerificationRecord": {
      "verificationDate": "dateTime (ISO 8601)",
      "verificationMethod": "string",
      "verificationResult": "boolean",
      "verificationEvidence": "string or URI"
    }
  },
  "processingMetadata": {
    "processingSteps": [
      {
        "processingType": "string (cleaning, format conversion, etc.)",
        "processingDate": "dateTime (ISO 8601)",
        "processingAgent": "string (software identifier)",
        "processingDescription": "string",
        "inputHashes": ["string (hash values of inputs)"],
        "outputHashes": ["string (hash values of outputs)"]
      }
    ],
    "transformationParameters": {
      "additionalProperties": true
    }
  },
  "usageMetadata": {
    "datasets": [
      {
        "datasetId": "string (dataset identifier)",
        "inclusionDate": "dateTime (ISO 8601)",
        "usageScope": "string (purpose description)"
      }
    ],
    "models": [
      {
        "modelId": "string (model identifier)",
        "trainingDate": "dateTime (ISO 8601)",
        "usageType": "string (training, fine-tuning, etc.)"
      }
    ],
    "attributions": [
      {
        "attributionDate": "dateTime (ISO 8601)",
        "attributionMethod": "string",
        "attributionEvidence": "string or URI"
      }
    ]
  },
  "provenanceIntegrity": {
    "provenanceCreationDate": "dateTime (ISO 8601)",
    "previousRecordHash": "string (hash of previous version if updated)",
    "provenanceSignature": {
      "signatureAlgorithm": "string",
      "signatureValue": "string (base64)",
      "signatureIdentity": "string (signer identifier)"
    }
  }
}
```

### 4.3 Chain of Custody

The system implements an unbroken chain of custody with:

1. **Cryptographic Linking**: Each processing step links to previous steps with cryptographic hashes
2. **Temporal Consistency**: Timestamp verification ensures chronological integrity
3. **Identity Verification**: All agents in the chain are authenticated and recorded
4. **Transformation Transparency**: All content modifications are documented with parameters
5. **Multi-Party Verification**: Critical steps can require multiple independent verifications

## 5. Technical Implementation Details

### 5.1 Database Schema

**Relational Schema for Permission Registry:**

```sql
CREATE TABLE Sources (
    source_id UUID PRIMARY KEY,
    canonical_uri TEXT NOT NULL,
    domain TEXT GENERATED ALWAYS AS (extract_domain(canonical_uri)) STORED,
    source_type TEXT NOT NULL,
    first_discovered TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    last_checked TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(canonical_uri)
);

CREATE TABLE Permissions (
    permission_id UUID PRIMARY KEY,
    source_id UUID REFERENCES Sources(source_id),
    permission_version INTEGER NOT NULL,
    permission_status TEXT NOT NULL,
    declaration_method TEXT NOT NULL,
    declaration_location TEXT NOT NULL,
    declaration_timestamp TIMESTAMP WITH TIME ZONE NOT NULL,
    valid_from TIMESTAMP WITH TIME ZONE NOT NULL,
    valid_until TIMESTAMP WITH TIME ZONE,
    permission_data JSONB NOT NULL,
    signature_data JSONB NOT NULL,
    verification_status TEXT NOT NULL,
    verification_timestamp TIMESTAMP WITH TIME ZONE NOT NULL,
    UNIQUE(source_id, permission_version)
);

CREATE TABLE ContentItems (
    content_id UUID PRIMARY KEY,
    source_id UUID REFERENCES Sources(source_id),
    canonical_identifier TEXT NOT NULL,
    content_type TEXT NOT NULL,
    hash_sha256 TEXT NOT NULL,
    perceptual_hash TEXT,
    content_metadata JSONB NOT NULL,
    acquisition_timestamp TIMESTAMP WITH TIME ZONE NOT NULL,
    permission_id UUID REFERENCES Permissions(permission_id),
    verification_status TEXT NOT NULL,
    provenance_record JSONB NOT NULL,
    provenance_signature JSONB NOT NULL,
    UNIQUE(hash_sha256)
);

CREATE TABLE ContentTransformations (
    transformation_id UUID PRIMARY KEY,
    content_id UUID REFERENCES ContentItems(content_id),
    transformation_type TEXT NOT NULL,
    transformation_timestamp TIMESTAMP WITH TIME ZONE NOT NULL,
    transformation_agent TEXT NOT NULL,
    input_hash TEXT NOT NULL,
    output_hash TEXT NOT NULL,
    transformation_parameters JSONB NOT NULL,
    provenance_update JSONB NOT NULL,
    provenance_signature JSONB NOT NULL
);

CREATE TABLE DatasetInclusions (
    inclusion_id UUID PRIMARY KEY,
    content_id UUID REFERENCES ContentItems(content_id),
    dataset_id UUID NOT NULL,
    inclusion_timestamp TIMESTAMP WITH TIME ZONE NOT NULL,
    inclusion_purpose TEXT NOT NULL,
    attribution_record JSONB,
    provenance_update JSONB NOT NULL,
    provenance_signature JSONB NOT NULL
);

CREATE TABLE UsageReports (
    usage_id UUID PRIMARY KEY,
    content_id UUID REFERENCES ContentItems(content_id),
    model_id UUID NOT NULL,
    usage_type TEXT NOT NULL,
    usage_timestamp TIMESTAMP WITH TIME ZONE NOT NULL,
    attribution_evidence JSONB,
    compensation_record JSONB,
    provenance_update JSONB NOT NULL,
    provenance_signature JSONB NOT NULL
);
```

**Blockchain Schema (for immutable provenance logging):**

```
Block {
    Header {
        previousBlockHash
        merkleRoot
        timestamp
        difficulty
        nonce
    }
    TransactionList [
        Transaction {
            transactionType (Permission|Content|Transformation|Usage)
            transactionData (Schema-specific JSON)
            signature
            publicKeyId
        }
    ]
}
```

### 5.2 API Specifications

#### 5.2.1 Permission Registry API

```openapi
openapi: 3.0.0
info:
  title: Permission Registry API
  version: 1.0.0
paths:
  /permissions/verify:
    post:
      summary: Verify permission for content usage
      requestBody:
        content:
          application/json:
            schema:
              type: object
              properties:
                sourceUri:
                  type: string
                contentType:
                  type: string
                usageType:
                  type: string
      responses:
        '200':
          description: Permission verification result
          content:
            application/json:
              schema:
                type: object
                properties:
                  permissionStatus:
                    type: string
                  permissionDetails:
                    type: object
                  verificationProof:
                    type: object
  
  /permissions/register:
    post:
      summary: Register new permission declaration
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/PermissionRegistration'
      responses:
        '201':
          description: Permission successfully registered
          content:
            application/json:
              schema:
                type: object
                properties:
                  permissionId:
                    type: string
                  registrationStatus:
                    type: string
                  registrationTimestamp:
                    type: string
                    format: date-time
```

#### 5.2.2 Content Provenance API

```openapi
openapi: 3.0.0
info:
  title: Content Provenance API
  version: 1.0.0
paths:
  /content/register:
    post:
      summary: Register new content with provenance
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/ContentRegistration'
      responses:
        '201':
          description: Content successfully registered
          content:
            application/json:
              schema:
                type: object
                properties:
                  contentId:
                    type: string
                  provenanceId:
                    type: string
                  registrationStatus:
                    type: string

  /content/{contentId}/provenance:
    get:
      summary: Get provenance record for content
      parameters:
        - name: contentId
          in: path
          required: true
          schema:
            type: string
      responses:
        '200':
          description: Content provenance record
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ProvenanceRecord'
```

### 5.3 Cryptographic Implementation

The system uses:

1. **Digital Signatures**: 
   - Primary: Ed25519 (EdDSA) for efficiency and security
   - Alternative: ECDSA with P-256 for compatibility with existing web PKI

2. **Content Integrity**:
   - SHA-256 for standard content hashing
   - BLAKE3 for high-performance hashing of large volumes
   - ssdeep, PDQ, or pHash for perceptual hashing of media

3. **Secure Time**:
   - Signed timestamps from trusted timestamp services
   - Temporal proof of existence via blockchain anchoring
   - Multiple independent time sources for critical operations

### 5.4 Scalability Design

The system is designed to scale to web-scale content acquisition:

1. **Sharded Database Architecture**:
   - Horizontal partitioning of permission and provenance data by domain
   - Read replicas for high-volume permission verification
   - Cache layers for frequently accessed permissions

2. **Distributed Processing**:
   - Parallel crawlers with coordinated permission checking
   - Distributed content fingerprinting and verification
   - Queue-based provenance registration with guaranteed delivery

3. **Hierarchical Verification**:
   - Domain-level permissions with cascading inheritance
   - Batched verification of related content items
   - Merkle tree proofs for efficient verification of large datasets

## 6. Verification and Auditing

### 6.1 Permission Verification Process

1. **Real-time Verification Flow**:
   ```
   Content URL → Domain Extraction → Permission Declaration Lookup →
   Policy Interpretation → Signature Verification → Terms Evaluation →
   Permission Decision
   ```

2. **Offline Batch Verification**:
   ```
   Content Batch → Bulk Domain Resolution → Permission Cache Lookup →
   Missing Permission Acquisition → Batch Signature Verification →
   Verification Report Generation
   ```

3. **Dispute Resolution Process**:
   ```
   Dispute Claim → Evidence Collection → Timestamp Validation →
   Permission History Retrieval → Policy Interpretation →
   Technical Ruling → Documentation
   ```

### 6.2 Audit Logging Requirements

All operations must be logged with:

1. **Operation Metadata**:
   - Operation type and timestamp
   - Acting entity/system identifier
   - Affected resources (content, permissions)

2. **Decision Metadata**:
   - Decision type (allow, deny, conditional)
   - Policy references and versions
   - Decision rationale

3. **Technical Evidence**:
   - Cryptographic proofs used
   - Verification method details
   - External service references

### 6.3 Audit Interface

```openapi
openapi: 3.0.0
info:
  title: Audit Interface
  version: 1.0.0
paths:
  /audit/content/{contentId}:
    get:
      summary: Get audit trail for specific content
      parameters:
        - name: contentId
          in: path
          required: true
          schema:
            type: string
      responses:
        '200':
          description: Audit trail for content
          content:
            application/json:
              schema:
                type: object
                properties:
                  contentId:
                    type: string
                  auditEvents:
                    type: array
                    items:
                      $ref: '#/components/schemas/AuditEvent'
```

## 7. Integration Guidelines

### 7.1 For Content Creators

**Implementation Steps:**

1. Generate cryptographic key pair for signing permissions
2. Create permission policy using standard templates or custom terms
3. Implement chosen declaration method (robots.txt, HTTP headers, HTML meta)
4. Sign permission declaration with private key
5. Register public key with verification service
6. Implement verification endpoint (optional)

**Code Example (Python - Permission Generation):**

```python
import uuid
import time
import json
import base64
import nacl.signing

# Create permission policy
policy = {
    "permissionId": str(uuid.uuid4()),
    "sourceIdentifier": "https://example.com",
    "permissionType": "Conditional",
    "contentTypes": ["Text", "Image"],
    "usageScopes": ["Training", "NonCommercial"],
    "restrictions": {
        "requireAttribution": True,
        "attributionFormat": "Content from {source}",
        "requireCompensation": False
    },
    "licensingTerms": {
        "licenseType": "CC-BY-NC-4.0",
        "validFrom": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
        "validUntil": None
    },
    "contactInformation": {
        "contactType": "Technical",
        "contactMethod": "Email",
        "contactValue": "permissions@example.com"
    }
}

# Sign the policy
signing_key = nacl.signing.SigningKey.generate()
policy_bytes = json.dumps(policy, sort_keys=True).encode('utf-8')
signature = signing_key.sign(policy_bytes)
signature_b64 = base64.b64encode(signature.signature).decode('ascii')

# Add verification metadata
policy["verificationMetadata"] = {
    "declarationTimestamp": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
    "signatureMethod": "ed25519",
    "signature": signature_b64,
    "publicKeyId": base64.b64encode(signing_key.verify_key.encode()).decode('ascii')
}

# Generate robots.txt entries
robots_txt = f"""
User-agent: AI-Training-Crawler
Allow: /blog/
Disallow: /personal/

AI-Training: allowed
AI-Training-Version: 1.0
AI-Training-Policy-ID: {policy["permissionId"]}
AI-Training-Content-Types: text,images
AI-Training-License: CC-BY-NC-4.0
AI-Training-Signature: ed25519:{signature_b64}
"""

print(robots_txt)
```

### 7.2 For Dataset Creators

**Implementation Steps:**

1. Implement permission verification during content acquisition
2. Generate and store content fingerprints
3. Create and sign provenance records
4. Register provenance in provenance database
5. Implement compliance verification before dataset publication
6. Include provenance information in dataset metadata

**Code Example (Python - Content Registration):**

```python
import hashlib
import requests
import uuid
import time
import json
import base64
import nacl.signing

# Content metadata
content = {
    "url": "https://example.com/article.html",
    "title": "Example Article",
    "contentType": "text/html",
    "acquisitionDate": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())
}

# Get content and compute hash
response = requests.get(content["url"])
content_bytes = response.content
content_hash = hashlib.sha256(content_bytes).hexdigest()

# Verify permission
permission_verification = requests.post(
    "https://permissions.example.org/permissions/verify",
    json={
        "sourceUri": content["url"],
        "contentType": content["contentType"],
        "usageType": "Training"
    }
)
permission_result = permission_verification.json()

if permission_result["permissionStatus"] != "allowed":
    raise Exception(f"Permission denied: {permission_result}")

# Create provenance record
provenance_record = {
    "contentId": {
        "canonicalId": content["url"],
        "contentHashes": [
            {
                "algorithm": "sha256",
                "value": content_hash,
                "scope": "full"
            }
        ]
    },
    "contentMetadata": {
        "title": content["title"],
        "contentType": content["contentType"]
    },
    "acquisitionMetadata": {
        "acquisitionMethod": "crawl",
        "acquisitionDate": content["acquisitionDate"],
        "acquisitionAgent": "ExampleCrawler/1.0",
        "permissionId": permission_result["permissionDetails"]["permissionId"],
        "permissionVerificationRecord": {
            "verificationDate": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
            "verificationMethod": "API",
            "verificationResult": True,
            "verificationEvidence": str(permission_result["verificationProof"])
        }
    },
    "provenanceIntegrity": {
        "provenanceCreationDate": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())
    }
}

# Sign provenance record
signing_key = nacl.signing.SigningKey.generate()
provenance_bytes = json.dumps(provenance_record, sort_keys=True).encode('utf-8')
signature = signing_key.sign(provenance_bytes)
signature_b64 = base64.b64encode(signature.signature).decode('ascii')

provenance_record["provenanceIntegrity"]["provenanceSignature"] = {
    "signatureAlgorithm": "ed25519",
    "signatureValue": signature_b64,
    "signatureIdentity": "ExampleDatasetCreator"
}

# Register provenance
provenance_registration = requests.post(
    "https://provenance.example.org/content/register",
    json={
        "content": {
            "sourceUri": content["url"],
            "contentHash": content_hash,
            "contentType": content["contentType"]
        },
        "provenance": provenance_record
    }
)

registration_result = provenance_registration.json()
print(f"Content registered with ID: {registration_result['contentId']}")
```

## 8. Future Roadmap

### 8.1 Standards Development

- Work with W3C to formalize AI Training Permissions Extension
- Collaborate with schema.org to extend metadata vocabulary
- Participate in ISO standardization for content provenance
- Create industry alliance for permission protocol adoption

### 8.2 Technical Enhancements

- Federated verification network with decentralized trust
- Advanced ML-based content fingerprinting for robust identification
- Zero-knowledge proofs for privacy-preserving verification
- Smart contract integration for automated compensation

### 8.3 Ecosystem Growth

- Permission management tools for content creators and websites
- Dataset compliance certification services
- Model provenance verification services
- Regulatory compliance reporting tools

## 9. Appendices

### 9.1 Glossary

- **Provenance**: Complete lineage of content from original source through all transformations
- **Permission Declaration**: Explicit statement of allowed uses from content creator/owner
- **Content Fingerprint**: Unique identifier derived from content characteristics
- **Verification**: Process of confirming authenticity and integrity of permissions or content
- **Attribution**: Proper crediting of original creators in derived works

### 9.2 Example Implementations

[To be expanded with code repositories and reference implementations]

### 9.3 Data Exchange Formats

[To be expanded with example JSON/XML schemas and validation tools]