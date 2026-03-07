---
name: project-planning
title: Project Planning Generator
description: Transform a product idea or product requirement into a structured project plan including epics, features, tasks, and subtasks required to deliver the product.
category: project_management
tags:
  - project-planning
  - product-management
  - agile
  - software-development
  - task-breakdown
version: 1.0
author: ai-agent-skill
inputs:
  - product_description
  - product_requirements
optional_inputs:
  - product_idea
  - mvp_scope
  - timeline
  - team_size
  - team_roles
  - technical_constraints
  - non_functional_requirements
outputs:
  - project_plan
---

# Skill: Project Planning Generator

## Purpose

Convert a **product idea or product requirement** into a structured **project plan**.

The skill decomposes the work into multiple planning layers:

- Epics
- Features
- Tasks
- Subtasks

This structure helps teams manage delivery using **Agile, Scrum, or Kanban** workflows.

---

# Inputs

## Required Inputs

### Product Description

High-level explanation of the product.

Example:

A durian traceability platform that allows farms, exporters, and regulators to track the origin of durian batches.

---

### Product Requirements

Functional requirements of the product.

Example:

- Farm registration
- Batch tracking
- QR verification
- Export certification

---

## Optional Inputs

These inputs improve planning quality.

- MVP scope
- timeline
- team size
- team roles
- technical constraints
- non-functional requirements

Example:

Team size: 5 engineers  
Timeline: 4 months  
Architecture: microservices

---

# Planning Workflow

The agent must follow this structured breakdown process.

---

## Step 1 — Identify Major Product Domains

Group the system into **logical domains** such as:

- authentication
- user management
- product tracking
- analytics
- integrations

These domains typically become **Epics**.

---

## Step 2 — Define Epics

Epics represent **major functional capabilities** of the product.

Examples:

- Authentication System
- Farm Management
- Crop Batch Tracking
- QR Verification System
- Reporting Dashboard

---

## Step 3 — Break Epics into Features

Each Epic is divided into **features**.

Example:

Epic: Authentication System

Features:

- User registration
- Login
- Role-based access control
- Password reset

---

## Step 4 — Break Features into Tasks

Tasks represent **engineering work items**.

Example:

Feature: User Login

Tasks:

- Create login API
- Implement password validation
- Generate access tokens
- Add login UI

---

## Step 5 — Break Tasks into Subtasks

Subtasks represent **small actionable steps**.

Example:

Task: Create login API

Subtasks:

- Design API schema
- Implement endpoint
- Add unit tests
- Add API documentation

---

# Output Format

The project plan must be structured as follows.

```
# PROJECT PLAN

## Epic 1: Authentication System

### Feature 1.1: User Registration

Tasks

- Design registration API
- Implement registration endpoint
- Create user database schema
- Add email verification

### Feature 1.2: User Login

Tasks

- Implement login API
- Password validation
- Generate JWT token
- Login UI

## Epic 2: Farm Management

### Feature 2.1: Farm Registration

Tasks

- Farm database schema
- Create farm registration API
- Farm verification workflow
```


---

# Planning Principles

The agent must follow these principles.

### Prefer MVP-first planning

Focus on **minimal features required to release the first version**.

---

### Tasks must be implementable

Avoid vague tasks such as:

Bad example:

Improve system performance

Better example:

Add Redis caching for farm lookup API

---

### Keep tasks small

Tasks should ideally take **1 day or less** of engineering work.

---

### Avoid duplicate tasks

Ensure tasks are clearly scoped.

---

# Example

## Product

Durian Traceability Platform

---

Epic 1: Authentication

Feature: User Registration

Tasks

- Create user table
- Implement registration API
- Email verification service
- Registration UI

---

Epic 2: Batch Tracking

Feature: Create Crop Batch

Tasks

- Design batch schema
- Implement batch creation API
- Add farm linkage
- Generate batch ID

---

Epic 3: QR Verification

Feature: QR Code Generation

Tasks

- Generate QR code for batch
- Store QR metadata
- QR verification endpoint