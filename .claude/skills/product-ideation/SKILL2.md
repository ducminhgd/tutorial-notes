---
name: product-ideation
title: Product Idea Generator & Reviewer
description: Generate new product ideas or analyze and improve existing product ideas, transforming vague concepts into structured product definitions and MVP requirements.
category: product
tags:
  - product
  - ideation
  - product-management
  - startup
  - requirements
version: 1.0
author: ai-agent-skill
inputs:
  - problem_statement
  - product_idea
optional_inputs:
  - target_users
  - industry
  - region
  - technology_preferences
  - business_model
  - constraints
outputs:
  - structured_product_idea
---

# Skill: Product Idea Generator & Reviewer

## Purpose

Generate new product ideas or analyze and improve existing product ideas.  
The skill transforms vague ideas into **clear, structured product concepts and initial requirements**.

The skill supports two modes:

1. **Idea Generation Mode** — create new product ideas from a problem.
2. **Idea Improvement Mode** — refine and clarify an existing product idea.

---

# Inputs

## Required Input

One of the following:

### A. Problem Statement

A real-world problem that needs solving.

Example:

Small farmers cannot prove the origin of their crops.

### B. Product Idea

An existing idea that needs improvement.

Example:

A mobile app for durian traceability.

---

## Optional Inputs

Additional context can improve the result.

- Target users
- Industry or domain
- Region or market
- Technology preferences
- Business model preference
- Constraints

Example:

Target users: farmers and exporters  
Industry: agriculture  
Region: Southeast Asia  
Technology preference: mobile + QR code

---

# Reasoning Workflow

The agent must follow this reasoning process.

## Step 1 — Understand Context

Identify:

- the problem
- target users
- environment
- constraints

---

## Step 2 — Identify Core Value

Determine:

- the pain point being solved
- why current solutions are insufficient

---

## Step 3 — Define Product Concept

Describe:

- the main idea
- how the system works
- who will use it

---

## Step 4 — Identify Core Features

List **5–10 core product features** that deliver the main value.

Examples:

- authentication
- traceability
- analytics dashboard
- alerts
- integrations

---

## Step 5 — Define Differentiation

Explain the product's **competitive advantage**:

- innovation
- cost advantage
- usability
- unique technology

---

## Step 6 — Rewrite the Product Requirement

Rewrite the idea as a **clear, structured product definition**.

Avoid vague language.

---

# Output Format

The result must follow this structure.

```
# PRODUCT IDEA

**Name**
Short product name

**Description**
Short explanation of the product

**Problem**
What problem this product solves

**Target Users**
Who will use the product

**Solution**
How the product solves the problem

## Core Features
1.
2.
3.
4.
5.

## Differentiation

Why this product is unique

## MVP Scope

Minimum set of features for first release

## Possible Risks

Technical or business risks
```

---

# Quality Rules

The agent must:

- Focus on **real problems**
- Prefer **simple MVP solutions**
- Avoid unrealistic technology assumptions
- Avoid overly broad products
- Ensure features are **practical and buildable**

---

# Example

## Product Name

FarmTrace

## Description

A crop traceability system that allows farmers and exporters to prove the origin of agricultural products.

## Problem

Consumers and exporters cannot verify the origin of crops, leading to fraud and reduced trust.

## Target Users

- farmers
- exporters
- regulators
- consumers

## Solution

FarmTrace records crop production data and supply chain steps and generates QR codes for verification.

## Core Features

1. Farm registration
2. Crop batch tracking
3. QR code generation
4. Supply chain logging
5. Consumer verification portal

## Differentiation

- tamper-resistant records
- full supply chain visibility
- export compliance support

## MVP Scope

- farm registration
- batch tracking
- QR verification

## Possible Risks

- farmer adoption
- incorrect data entry
- supply chain integration challenges