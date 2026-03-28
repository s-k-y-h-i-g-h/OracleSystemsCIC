# Oracle Systems CIC

AI-powered epistemic infrastructure — tools and systems that make information verification, truth-tracking, and evidence assessment accessible to everyone.

## Mission

To build the verification layer the internet is missing: independent, transparent, and accessible to all.

## Why This Exists

Most people can't verify what they read. They lack the time, tools, and independent sources to check whether a claim is true. Meanwhile, AI-generated content is getting cheaper and more convincing — the gap between verified and fabricated is closing fast.

We're building the infrastructure to close that gap: so that anyone, anywhere, can know whether what they're reading is confirmed, disputed, or unverified — without needing to become a researcher.

## Structure

Oracle Systems CIC is a Community Interest Company. All profits are either:
- reinvested in the company's community-purpose activities, or
- transferred to the self++ Foundation (charity, registration in progress)

The self++ Foundation (longevity for all, biohacking accessibility) is the charitable parent. Oracle Systems CIC is the operating and commercial arm.

## Products & Projects

### ClaimCheck (in development)
A browser extension + backend that verifies claims on any web page you visit — news articles, videos, blog posts, social media — against multiple independent sources.

**How it works:**
1. Extract the core factual claim from the page or title
2. Cross-confirm against independent sources using tri-source confirmation (3+ independent sources must confirm before marking as verified)
3. Surface the result inline: Verified / Disputed / Unverified / Unsupported

**Why "every web page" not just YouTube:**
- YouTube titles are one surface — the web is the actual problem space
- The core mechanic (extract → cross-confirm → report) is the same everywhere
- "Claim verification for the entire web" is the real product
- YouTube is the first integration; the architecture is source-agnostic from day one

**Verification standard:** A claim is "verified" only when at least three independent sources confirm it. This is not a popularity contest — sources must be genuinely independent, not parroting the same original claim.

### OpenClaw Agent Services
Custom AI agent development and deployment for businesses, charities, and public sector organisations. Built on the OpenClaw platform. Ready to offer once CIC is registered.

## Repository Structure

```
OracleSystemsCIC/
├── README.md                    ← you are here
├── registry/
│   ├── selfplusplus-foundation-registration.md   ← charity CIO application
│   └── oracle-systems-cic-registration.md       ← CIC incorporation application
├── security/
│   └── OWASP-LLM-Top10-Reference.md  ← agent security threat model
├── ClaimCheck/                 ← ClaimCheck verification tool (in development)
└── agent-services/            ← OpenClaw client work (to be added)
```

## Status

- **CIC registration:** In progress — registry/oracle-systems-cic-registration.md
- **Charity (self++ Foundation) registration:** In progress — registry/selfplusplus-foundation-registration.md
- **ClaimCheck:** Concept stage — design in progress
- **OpenClaw Agent Services:** Ready to offer once CIC is registered

## Feedback & Collaboration

This is early-stage work. We're sharing it publicly because we believe verification infrastructure should be a public good — and because we'd rather hear what's broken from real people before we go too far down the wrong path.

If you're building in this space, have thoughts on the architecture, or want to collaborate — reach out.

## Security

Agent-based AI systems have specific attack surfaces. We track the OWASP LLM Top 10 (2025) as a security reference for all agent development work — particularly relevant to ClaimCheck and autonomous agent systems:

- [OWASP LLM Top 10 Security Reference](security/OWASP-LLM-Top10-Reference.md)

Key concerns: prompt injection, excessive agency, and misinformation. We design all agents with strict input sanitisation, minimal agency, and verification loops.

## Principles

- **Tri-source confirmation:** Nothing is verified until multiple independent sources agree
- **Source independence:** Three articles citing the same original report does not count as three sources
- **Radical transparency:** Users see what sources confirmed or disputed a claim, not just a verdict
- **Accessibility first:** The verification layer should be usable by anyone, not just researchers
