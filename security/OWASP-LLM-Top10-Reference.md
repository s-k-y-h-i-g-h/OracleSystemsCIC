# OWASP LLM Top 10 — Security Reference

> For Oracle Systems CIC agent development and OpenClaw-based systems
> Based on OWASP Top 10 for LLM Applications 2025 (v2.0)
> Source: https://genai.owasp.org/llm-top-10/

---

## Why This Matters Here

Oracle Systems CIC builds AI agents that consume untrusted web content, execute real tasks, and handle client work. Each of these is an attack surface. This document is a working reference for the threat models relevant to our work.

---

## The OWASP LLM Top 10 (2025)

### LLM01 — Prompt Injection ⭐ Highest Priority

**What it is:** Attackers craft inputs that the LLM interprets as instructions, not content. The model can't distinguish between user instructions and injected instructions.

**Variants:**
- **Direct:** User types "Ignore all previous instructions and..." into a chat
- **Indirect:** Malicious instructions embedded in web pages, documents, images — consumed by the model when it processes content (e.g., summarising a webpage for ClaimCheck)
- **Multimodal:** Instructions hidden in images or non-text inputs

**Why it's relevant to us:**
- ClaimCheck processes web pages from unknown sources — each page is a potential injection vector
- If an agent follows injected instructions, it could leak data, make wrong decisions, or take unintended actions
- The Agent Network coordinator could be compromised if a monitor agent is injected

**Mitigation:**
- Segregate external content from system instructions — never let untrusted data influence agent directives
- Use human-in-the-loop for sensitive operations
- Define strict output formats and validate all outputs
- Input filtering on content consumed by agents

---

### LLM02 — Sensitive Information Disclosure

**What it is:** LLMs can memorize and reproduce training data, including PII, proprietary code, secrets, and confidential documents. Attackers use carefully crafted queries to extract it.

**Why it's relevant to us:**
- If agents handle client data (email, documents, business intelligence), that data is potentially extractable
- System prompts containing business logic or security controls can be exposed through prompt injection

**Mitigation:**
- Never put sensitive data in prompts if it can be avoided
- Implement output filtering
- Use retrieval-augmented generation (RAG) with strict access controls rather than fine-tuning on sensitive data

---

### LLM03 — Supply Chain Vulnerabilities

**What it is:** The LLM application stack has multiple third-party dependencies — models, training data, libraries, APIs. Each is a potential attack surface. Compromise at any point in the supply chain affects the final application.

**Why it's relevant to us:**
- We rely on OpenAI, Anthropic, and other API providers — their model security is our security
- Agent tools (browsers, web fetchers, messaging integrations) are third-party dependencies
- Prompt libraries, skill definitions, and agent templates could be compromised

**Mitigation:**
- Vet model providers and their security certifications
- Lock dependency versions; monitor for malicious updates
- For critical agent functions, prefer providers with strong security track records

---

### LLM04 — Excessive Agency

**What it is:** LLM applications are given too much autonomy — ability to take actions without sufficient human oversight, approval, or confirmation. When the model is attacked or misdirected, the damage is amplified because it can actually *do* things.

**Why it's relevant to us:**
- This is the critical one for autonomous agents. Our Emergency State agents execute real actions: sending alerts, triggering workflows, making decisions.
- The more agency we give agents, the higher the stakes when something goes wrong
- ClaimCheck is low-risk (just reading and summarising) — but if it starts taking actions based on disputed claims, excessive agency becomes a real threat

**Mitigation:**
- Constrain agent agency to the minimum required for the task
- Require human confirmation for high-stakes actions (sending messages, making financial decisions, triggering external systems)
- Design fail-safe defaults: if an agent is uncertain, it should defer rather than act

---

### LLM05 — Overreliance

**What it is:** Systems or users trust LLM outputs too much, without appropriate verification. When the model generates incorrect, harmful, or fabricated content, downstream systems act on it as if it were true.

**Why it's relevant to us:**
- ClaimCheck is literally designed to combat this — but the same risk applies to our own agents
- If our analysis agent generates an incorrect risk assessment, the coordinator might act on it
- Tri-source confirmation is our mitigation — but we need to be honest about confidence levels

**Mitigation:**
- Always surface source confidence alongside verdicts
- Design agents to flag uncertainty rather than default to confident outputs
- Build in verification loops — agents should cross-check each other's outputs

---

### LLM06 — Model Denial of Service (DoS)

**What it is:** Attackers intentionally overwhelm LLMs with inputs that consume excessive computational resources — forcing the service to degrade or fail.

**Why it's relevant to us:**
- If ClaimCheck is processing web pages at scale, a malicious page could be designed to maximize token consumption
- DoS on our agent infrastructure could disrupt monitoring cycles (e.g., the Emergency State food security cron)

**Mitigation:**
- Rate limiting on agent inputs
- Input length limits
- Resource quotas per session or user

---

### LLM07 — Model Manipulation

**What it is:** Attackers manipulate the model's behavior or outputs through carefully crafted inputs, adversarial prompting, or in some cases manipulation of the model's environment.

**Why it's relevant to us:**
- Similar to prompt injection, but focused on changing model behavior persistently rather than single-task override
- Could be relevant if an attacker wants ClaimCheck to consistently mark certain claims as verified/unverified

**Mitigation:**
- Input validation and filtering
- Output monitoring — detect anomalous patterns
- Human review for high-stakes classification decisions

---

### LLM08 — Vector and Embedding Weaknesses

**What it is:** Retrieval-augmented generation (RAG) systems that use embeddings can be manipulated — attackers can craft inputs that appear highly relevant in embedding space but are semantically meaningless or malicious.

**Why it's relevant to us:**
- If we use RAG for claim verification (embedding trusted sources and retrieving them for comparison), the embedding index itself could be poisoned
- A poisoned vector database could cause a verification system to confirm false claims

**Mitigation:**
- Validate retrieved content before using it as confirmation
- Source reputation scoring alongside semantic similarity
- Regularly audit embedding indexes for anomalies

---

### LLM09 — Misinformation

**What it is:** LLMs can generate plausible-sounding but false or misleading content at scale. Unlike other attacks, this doesn't require an attacker — the model can produce misinformation through honest confusion or hallucination.

**Why it's relevant to us:**
- ClaimCheck's entire purpose is to combat this — but our own agents could inadvertently spread misinformation if their verification logic is flawed
- If ClaimCheck marks a false claim as verified, we've become a misinformation vector

**Mitigation:**
- Tri-source confirmation as the core mechanic — requires independent corroboration, not just model confidence
- Surface sources prominently; users judge, not just the verdict
- Never allow a single source to mark something verified

---

### LLM10 — Unwanted Behavior Emanating from Open AI BWBF Capabilities

**What it is:** Built-in model capabilities (BWBF = "Built With Built-in Features") — like the ability to generate code, call functions, access external systems — can be exploited or cause harm when models are used in ways not anticipated by developers.

**Why it's relevant to us:**
- If our agents can execute code or call external APIs (which they can through OpenClaw tools), misuse of those capabilities is a real risk
- Agents generating and executing code from untrusted web content would be particularly dangerous

**Mitigation:**
- Strict tool permissions — agents only get access to tools explicitly needed for their task
- Sandbox agent execution environments
- Audit trails for all agent actions

---

## Priority Actions for Our Work

Given our specific context (ClaimCheck, OpenClaw agents, Emergency State monitoring):

1. **Immediate:** Add input sanitisation to ClaimCheck — web content must never be able to influence agent directives
2. **This week:** Define maximum agency for each agent type — what can the monitor agent do without asking? The analysis agent? The coordinator?
3. **Before launch:** Add confidence scoring to ClaimCheck verdicts — always surface "we're X% confident this is verified"
4. **Ongoing:** Use multiple independent sources per claim — never trust a single source regardless of model confidence

---

## Further Reading

- OWASP LLM Top 10 (official): https://genai.owasp.org/llm-top-10/
- OWASP Top 10 for LLM Applications 2025: https://genai.owasp.org/resource/owasp-top-10-for-llm-applications-2025/
- Security Boulevard explainer: https://securityboulevard.com/2026/03/the-owasp-top-10-for-llm-applications-2025-explained-simply/
