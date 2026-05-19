# AI in Production

<small>Ashwin Bilgi</small>

<small>*NEC Software Solutions — May 2026*</small>

---

## What blocks serious AI transformation?

---

<img src="images/travel.png" style="max-height: 75vh; object-fit: contain;"/>

---

<img src="images/ai-travel.png" style="max-height: 75vh; object-fit: contain;"/>

---

<img src="images/danger.png" style="max-height: 75vh; object-fit: contain;"/>

---

<img src="images/ai-vs-non-ai.png" style="max-height: 75vh; object-fit: contain;"/>

---

<small>

**46%** of AI proof-of-concepts scrapped before production.
<small>— S&P Global, 2025</small>

<br>

**6%** of companies fully trust AI agents for core processes.
<small>— HBR, 2025</small>

<br>

**89%** observe. **32%** still blocked on quality.
<small>— LangChain, 2026</small>

</small>

---

## Our tools are built for a different world

<small>

Aggregates.
Percentiles.
Long-tail latencies.

Built for the first kind of system.

</small>

---


## Failures compound

<small>

An agent with 90% reliability.
Six calls in a chain.

</small>

**51% success rate.**

---

## The one place it works

<small>

Coding agents.

  - Formal specification. 
  - Deterministic guardrails. 
  - Fast feedback. 
  - An expert human in the loop who owns the outcome.

</small>

---

## But does it, really? 

Cognitive surrender

<small>

Developers want it to work. They retry. They steer. They accept approximations.

At some point, acceptance becomes surrender.

</small>

---

## Customers don't write prompts the way developers do. 

<small>

End user inputs are lossy

Especially if they are on mobile.

</small>

---

## Desensitised

<small>

Customer support bots. Automated recruitment rejection emails.

Your users have been here before.

Every bad experience lowered the bar further.

</small>

---

## The real customer

<small>

The human whose judgment determines whether an AI interaction succeeded.

Not the buyer. 

</small>

---

# So how do we really run AI in production?

---

## Treat AI as an unreliable external service.

What does this mean?

---

## Isolate it

<small>

Separate your deterministic code from your non-deterministic code.

</small>

---

## Capture all state

<small>

Queues. Distributed logs. Event sourcing.

You already build systems where every state transition is recorded.

AI is no different.

</small>

---

## A letter

<svg viewBox="0 0 900 140" style="width: 95%; max-width: 1000px; margin: 40px auto; display: block; color: currentColor;" xmlns="http://www.w3.org/2000/svg">
  <g font-family="Source Sans Pro, Helvetica, sans-serif" font-size="32" fill="currentColor" stroke="currentColor" stroke-width="2">
    <rect x="20" y="40" width="100" height="60" rx="8" fill="none"/>
    <text x="70" y="80" text-anchor="middle" stroke="none">A</text>
    <line x1="130" y1="70" x2="195" y2="70"/>
    <polygon points="195,64 207,70 195,76" stroke="none"/>
    <rect x="220" y="40" width="100" height="60" rx="8" fill="none"/>
    <text x="270" y="80" text-anchor="middle" stroke="none">B</text>
    <line x1="330" y1="70" x2="395" y2="70"/>
    <polygon points="395,64 407,70 395,76" stroke="none"/>
    <rect x="420" y="40" width="100" height="60" rx="8" fill="none"/>
    <text x="470" y="80" text-anchor="middle" stroke="none">C</text>
    <line x1="530" y1="70" x2="595" y2="70"/>
    <polygon points="595,64 607,70 595,76" stroke="none"/>
    <rect x="620" y="40" width="100" height="60" rx="8" fill="none"/>
    <text x="670" y="80" text-anchor="middle" stroke="none">D</text>
    <line x1="730" y1="70" x2="795" y2="70"/>
    <polygon points="795,64 807,70 795,76" stroke="none"/>
    <rect x="820" y="40" width="100" height="60" rx="8" fill="none"/>
    <text x="870" y="80" text-anchor="middle" stroke="none">E</text>
  </g>
</svg>

---

## Lost

<svg viewBox="0 0 900 140" style="width: 95%; max-width: 1000px; margin: 40px auto; display: block; color: currentColor;" xmlns="http://www.w3.org/2000/svg">
  <g font-family="Source Sans Pro, Helvetica, sans-serif" font-size="32" fill="currentColor" stroke="currentColor" stroke-width="2">
    <rect x="20" y="40" width="100" height="60" rx="8" fill="none"/>
    <text x="70" y="80" text-anchor="middle" stroke="none">A</text>
    <line x1="130" y1="70" x2="185" y2="70"/>
    <polygon points="185,64 197,70 185,76" stroke="none"/>
    <rect x="200" y="40" width="100" height="60" rx="8" fill="none"/>
    <text x="250" y="80" text-anchor="middle" stroke="none">B</text>
    <line x1="310" y1="70" x2="365" y2="70"/>
    <polygon points="365,64 377,70 365,76" stroke="none"/>
    <rect x="380" y="40" width="100" height="60" rx="8" fill="none"/>
    <text x="430" y="80" text-anchor="middle" stroke="none">C</text>
    <text x="515" y="82" text-anchor="middle" stroke="none" font-size="42">✗</text>
    <g opacity="0.25">
      <rect x="555" y="40" width="100" height="60" rx="8" fill="none"/>
      <text x="605" y="80" text-anchor="middle" stroke="none">D</text>
      <line x1="665" y1="70" x2="720" y2="70"/>
      <polygon points="720,64 732,70 720,76" stroke="none"/>
      <rect x="735" y="40" width="100" height="60" rx="8" fill="none"/>
      <text x="785" y="80" text-anchor="middle" stroke="none">E</text>
    </g>
  </g>
</svg>

---

## A copy at every hop

<svg viewBox="0 0 900 200" style="width: 95%; max-width: 1000px; margin: 30px auto; display: block; color: currentColor;" xmlns="http://www.w3.org/2000/svg">
  <g font-family="Source Sans Pro, Helvetica, sans-serif" font-size="32" fill="currentColor" stroke="currentColor" stroke-width="2">
    <rect x="20" y="30" width="100" height="60" rx="8" fill="none"/>
    <text x="70" y="70" text-anchor="middle" stroke="none">A</text>
    <g opacity="0.6" stroke-width="1.5">
      <rect x="45" y="115" width="50" height="60" rx="3" fill="none"/>
      <line x1="53" y1="128" x2="87" y2="128"/>
      <line x1="53" y1="142" x2="87" y2="142"/>
      <line x1="53" y1="156" x2="87" y2="156"/>
    </g>
    <line x1="130" y1="60" x2="185" y2="60"/>
    <polygon points="185,54 197,60 185,66" stroke="none"/>
    <rect x="200" y="30" width="100" height="60" rx="8" fill="none"/>
    <text x="250" y="70" text-anchor="middle" stroke="none">B</text>
    <g opacity="0.6" stroke-width="1.5">
      <rect x="225" y="115" width="50" height="60" rx="3" fill="none"/>
      <line x1="233" y1="128" x2="267" y2="128"/>
      <line x1="233" y1="142" x2="267" y2="142"/>
      <line x1="233" y1="156" x2="267" y2="156"/>
    </g>
    <line x1="310" y1="60" x2="365" y2="60"/>
    <polygon points="365,54 377,60 365,66" stroke="none"/>
    <rect x="380" y="30" width="100" height="60" rx="8" fill="none"/>
    <text x="430" y="70" text-anchor="middle" stroke="none">C</text>
    <g opacity="0.6" stroke-width="1.5">
      <rect x="405" y="115" width="50" height="60" rx="3" fill="none"/>
      <line x1="413" y1="128" x2="447" y2="128"/>
      <line x1="413" y1="142" x2="447" y2="142"/>
      <line x1="413" y1="156" x2="447" y2="156"/>
    </g>
    <line x1="490" y1="60" x2="545" y2="60"/>
    <polygon points="545,54 557,60 545,66" stroke="none"/>
    <rect x="560" y="30" width="100" height="60" rx="8" fill="none"/>
    <text x="610" y="70" text-anchor="middle" stroke="none">D</text>
    <g opacity="0.6" stroke-width="1.5">
      <rect x="585" y="115" width="50" height="60" rx="3" fill="none"/>
      <line x1="593" y1="128" x2="627" y2="128"/>
      <line x1="593" y1="142" x2="627" y2="142"/>
      <line x1="593" y1="156" x2="627" y2="156"/>
    </g>
    <line x1="670" y1="60" x2="725" y2="60"/>
    <polygon points="725,54 737,60 725,66" stroke="none"/>
    <rect x="740" y="30" width="100" height="60" rx="8" fill="none"/>
    <text x="790" y="70" text-anchor="middle" stroke="none">E</text>
    <g opacity="0.6" stroke-width="1.5">
      <rect x="765" y="115" width="50" height="60" rx="3" fill="none"/>
      <line x1="773" y1="128" x2="807" y2="128"/>
      <line x1="773" y1="142" x2="807" y2="142"/>
      <line x1="773" y1="156" x2="807" y2="156"/>
    </g>
  </g>
</svg>

---

## Design failure first

<small>

For every AI call: what does rollback look like? Retry? Escalation?

Compensating transactions are the  real product.

</small>

---

## Build on protocols

<small>

HTTP. REST. SQL.

You've always built on protocols, not products.

Push for, and watch out for standardisation. 

</small>

---

## Benchmark rigorously

<small>

Test plans. Acceptance criteria. Regression suites.

You already do this.

</small>

---

## Be able to swap models

<small>

You've migrated databases.
You've switched cloud providers.
Optimize for the ability to swap.

Your evaluation infrastructure is your competitive advantage.

</small>

---

<img src="images/ai-travel.png" style="max-height: 75vh; object-fit: contain;"/>

---

## The free text box is worth building.

Most teams just haven't been honest about what it takes.

---

# Questions?

---

# THANK YOU!