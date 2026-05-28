---
name: bhashalens-spec-generator
description: Generate and maintain high-fidelity technical blueprints and compiled PDF assets for BhashaLens monorepo components.
allowed-tools: Read, Write, Edit, Bash
version: 1.0
priority: HIGH
---

# BhashaLens Specification & Blueprint Generator

> **BHASHALENS AGENT SKILL** - Use this skill to compile, audit, and generate professional technical specifications, markdown blueprints, and publication-quality PDF assets for the BhashaLens monorepo.

---

## 📋 Core Purpose

This skill standardizes how documentation and system blueprints are maintained across the BhashaLens project. It binds together the underlying architecture description, ML quantization parameters, dataset matrices, and performance metrics, compiles them into structured documents, and outputs printable PDFs using low-level canvas layout scripts.

---

## 🏗️ Skill Directory Structure

This skill is designed as a fully modular, self-contained block:

```plaintext
.agent/skills/bhashalens-spec-generator/
├── SKILL.md                  # This instructions file
└── scripts/
    └── generate_pdf.py       # Programmatic ReportLab PDF compilation compiler
```

---

## 🔄 Core Workflows

### Workflow 1: Generate Blueprint & PDF
When the user asks to "regenerate the blueprint", "recompile specifications", or "update architecture PDF", execute this workflow:

1. **Verify Codebase Alignment:** Double check folder structures, active python training configurations, and model sizes.
2. **Execute PDF Generator:** Run the local ReportLab compiler script:
   ```bash
   python .agent/skills/bhashalens-spec-generator/scripts/generate_pdf.py docs/BhashaLens_Architecture_Blueprint.pdf
   ```
3. **Synchronize Markdown Spec Sheet:** Write or edit `docs/BhashaLens_Architecture_Blueprint.md` inside the `docs/` folder to ensure 100% parity with the generated PDF.

### Workflow 2: Synchronization Audit
Whenever model parameters (e.g. inside `student_config.py`), dataset scopes, or routing behaviors are altered, run this audit to synchronize:

1. Parse the new configurations (e.g., if target INT8 model drops from 14.8MB to 8.5MB).
2. Edit the layout tables and configuration codes in `.agent/skills/bhashalens-spec-generator/scripts/generate_pdf.py`.
3. Re-run Workflow 1 to regenerate all assets.

---

## 🛠️ Script Reference: generate_pdf.py

The compilation script uses ReportLab Flowables to construct multi-page PDF documents.

### Key Custom Parameters:
- **Canvas Class:** `NumberedCanvas` (manages running headers, footer separators, and dynamic "Page X of Y" total-count resolution).
- **Fonts Used:** `Helvetica`, `Helvetica-Bold`, `Helvetica-Oblique`, `Courier` (monospaced code representation).
- **Color Palette:** 
  - Primary Deep Navy: `#1E3A8A`
  - Accent Teal: `#0D9488`
  - Body Charcoal: `#0F172A`
  - Table Alternating Ice-White: `#F8FAFC`

---

## 📝 Self-Check & Validation

Before declaring the blueprint synchronization complete, always check:
- [ ] Did the ReportLab python script exit with code 0?
- [ ] Is `BhashaLens_Architecture_Blueprint.pdf` written directly in the `docs/` directory?
- [ ] Does `docs/BhashaLens_Architecture_Blueprint.md` match the PDF content structure?
- [ ] Are all dataset listings, loss formulas, and Flutter clean architecture charts fully updated with the latest codebase states?
