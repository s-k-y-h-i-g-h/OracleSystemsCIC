# Design System Strategy: The Diplomatic Observer

## 1. Overview & Creative North Star
**Creative North Star: "The Global Archive"**
This design system moves beyond the "SaaS dashboard" trope, leaning instead into a high-end editorial and diplomatic aesthetic. It treats data not as "widgets," but as a series of curated intelligence reports. We achieve this through **Informational Authority**—using expansive white space, purposeful asymmetry, and a refusal to use traditional borders. 

The layout should feel like a premium broadsheet newspaper met a high-tech situation room. By layering surfaces rather than boxing them in, we create an environment that feels open, transparent, and authoritative—qualities essential for a monitoring platform with a global mission.

---

### 2. Colors: Tonal Architecture
The palette is rooted in the UN Blue and Deep Navy, but its sophistication comes from how we handle the "in-between" spaces.

*   **Primary (`#00658e` / `#009edb`):** Use for active states and critical navigation.
*   **Tertiary/Alert (`#bf0028`):** Reserved strictly for "Risk" and "Action Required."
*   **The "No-Line" Rule:** 1px solid borders are strictly prohibited for sectioning. Boundaries must be defined solely through background color shifts. For example, a `surface-container-low` component should sit on a `surface` background to define its shape.
*   **Surface Hierarchy & Nesting:** Treat the UI as physical layers of fine vellum.
    *   **Base:** `surface` (#f8f9fa)
    *   **Sectioning:** `surface-container-low` (#f3f4f5)
    *   **Interactive Cards:** `surface-container-lowest` (#ffffff)
*   **The Glass & Gradient Rule:** For mobile headers or floating action panels, use Glassmorphism. Apply `surface-container-lowest` at 80% opacity with a `20px` backdrop-blur. Main CTAs should use a subtle linear gradient from `primary` to `primary_container` (top-left to bottom-right) to add "soul" and depth.

---

### 3. Typography: Editorial Clarity
We pair **Public Sans** (Display/Headlines) with **Inter** (Data/Body) to balance character with technical precision.

*   **Display & Headlines (Public Sans):** Large-scale and authoritative. Use `display-md` for primary dashboard stats. These should feel like news headlines—urgent but composed.
*   **Body & Labels (Inter):** Highly legible. `body-md` is the workhorse for data descriptions.
*   **Hierarchy as Identity:** Use `label-sm` in all-caps with `0.05rem` letter-spacing for metadata and category tags. This "Editorial Tag" style reinforces the feeling of a curated report.

---

### 4. Elevation & Depth: Tonal Layering
Traditional shadows are often a crutch for poor contrast. This system prioritizes **Tonal Layering**.

*   **The Layering Principle:** Depth is achieved by "stacking." A white card (`surface-container-lowest`) placed on a light grey background (`surface-container`) creates a natural lift.
*   **Ambient Shadows:** If a card must float (e.g., a critical risk alert), use an ultra-diffused shadow: `offset: 0 12px`, `blur: 32px`, `color: rgba(25, 28, 29, 0.04)`.
*   **The "Ghost Border" Fallback:** For high-density data tables where separation is mandatory, use a "Ghost Border": the `outline-variant` token at **15% opacity**. Never use 100% opaque lines.
*   **Glassmorphism:** Use for bottom navigation on mobile to allow data visualizations to peek through, maintaining a sense of place even while navigating.

---

### 5. Components: Precision Primitives

*   **Buttons:**
    *   **Primary:** Gradient fill (`primary` to `primary_container`), `rounded-md`, white text.
    *   **Secondary:** `surface-container-high` background with `on-surface` text. No border.
*   **Interactive Cards:** 
    *   No dividers. Use `spacing-6` (1.3rem) of internal padding. 
    *   Use background color shifts (`surface-container-low` vs `surface-container-highest`) to distinguish the header of a card from its body.
*   **Data Visualization:** 
    *   Charts should never have axes borders. Use `outline-variant` at low opacity for grid lines. 
    *   The "Alert Red" (`tertiary`) must only be used for data points that exceed a safety threshold.
*   **Input Fields:** 
    *   Use a "Filled" style with `surface-container-high`. 
    *   Focus state is indicated by a 2px bottom-bar of `primary`, never a full-box stroke.
*   **Status Chips:**
    *   High-contrast, small-scale. Use `primary-fixed` backgrounds for neutral status and `tertiary-fixed` for high-risk alerts.

---

### 6. Do's and Don'ts

#### Do:
*   **Embrace Negative Space:** If a dashboard feels "empty," increase the typography size of the headline rather than adding more borders or boxes.
*   **Use Asymmetry:** Place high-level KPIs on the left and a detailed "Intel Feed" on the right with different container widths (e.g., 60/40 split) to break the "standard grid" feel.
*   **Mobile-First Density:** On mobile, stack cards but use `spacing-px` (1px) gaps of the `surface-dim` color to create separation without adding visual weight.

#### Don't:
*   **No "Box-in-a-Box":** Avoid nesting more than two levels of containers. If you need a third level, use a typography shift (bold vs. regular) instead of a new background color.
*   **No Pure Black:** Never use `#000000`. Use `on-surface` (#191c1d) for text to maintain a premium, ink-on-paper feel.
*   **No Standard Shadows:** Avoid the "Material Design 2" look of heavy, dark shadows. If it looks like it's hovering an inch off the screen, it's too much.

---

### 7. Spacing Scale: The Breath of Data
Use the spacing scale to create a "rhythm of intelligence."
*   **Container Padding:** `8` (1.75rem) for desktop; `4` (0.9rem) for mobile.
*   **Component Gap:** `3` (0.6rem) for related items; `10` (2.25rem) for unrelated sections.
*   **Text Leading:** Always ensure body text has a line-height of at least 1.5 to maintain the "Editorial" feel.