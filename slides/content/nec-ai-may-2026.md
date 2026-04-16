# AI in Production

<small>Ashwin Bilgi</small>

<small>*NEC Software Solutions — May 2026*</small>

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

## Traditional code

Gets **more predictable** in production.

---

## AI

Gets **less predictable** in production.

---

## Our tools

<small>

Aggregates.
Percentiles.
Long-tail latencies.

<br>

Built for the first kind of system.

</small>

---

## AI inverts it

<small>

One wrong answer can be the whole story.

<br>

Aggregates hide it.

</small>

---

## And the input is lossy

<small>

Customers don't write prompts the way developers do.

Especially on mobile.
Especially on WhatsApp.

</small>

---

## The one place AI works

<small>

Developers with coding agents.

<br>

The developer steers, retries, wants it to work.

<br>

Your customers won't.

</small>

---

## Where the work is

<small>

Context engineering.

Long-running agents.

Tool curation.

Human-in-the-loop, by design.

</small>

---

## An infrastructure problem

<small>

The right context for the AI.

The right moment for the human.

Without overwhelming them.

</small>
