---
name: architecture-design
title: Software Architecture Design Generator
description: >
  Use this skill when the user wants to design system architecture, choose a technology stack, define coding conventions, create architecture diagrams, or map out system workflows and data flows. Trigger whenever the user says things like "design the architecture for", "what tech stack should I use", "how should I structure this system", "draw a diagram for", "design a microservice", "how should modules communicate", "what pattern should I use for", "design the database schema", "design an API", or asks how to architect any software system end-to-end. Also trigger when the user shares a PRD or project plan and wants the technical design, or asks to review/critique an existing architecture. This skill covers system design, component breakdown, tech stack selection, coding conventions, and Mermaid/PlantUML diagrams.
category: software_architecture
tags:
  - architecture
  - system-design
  - software-engineering
  - backend
  - distributed-systems
version: 1.0
author: ai-agent-skill
inputs:
  - product_description
  - product_requirements
optional_inputs:
  - non_functional_requirements
  - expected_scale
  - team_size
  - preferred_tech_stack
  - deployment_environment
  - integration_requirements
outputs:
  - architecture_design
---

# Skill: Software Architecture Design Generator

## Purpose

Design the **technical architecture of a software system** from product requirements.

The skill produces:

- system architecture
- technology stack
- service/component breakdown
- data architecture
- workflows
- coding conventions
- engineering guidelines

This helps engineering teams **start implementation with a clear blueprint**.

---

# Inputs

## Required Inputs

### Product Description

High-level explanation of the system.

Example:

A platform that allows farms and exporters to track the origin of durian products using QR codes.

---

### Product Requirements

Functional capabilities of the system.

Example:

- farm registration
- crop batch tracking
- QR code verification
- reporting dashboard

---

## Optional Inputs

These help produce better architecture.

- Non-functional requirements (performance, security, availability)
- Expected scale (users, requests per second, data size)
- Team size
- Preferred technology stack
- Deployment environment
- Integration requirements

Example:

Expected scale: 1M users  
Deployment: cloud (AWS or GCP)  
Architecture preference: microservices

---

# Architecture Design Workflow

The agent must follow this structured process.

---

## Step 1 — Identify System Type

Determine what kind of system it is.

Examples:

- web platform
- mobile + backend
- data platform
- real-time system
- distributed system

---

## Step 2 — Choose Architecture Style

Select the most appropriate architecture pattern.

Examples:

- Monolith
- Modular Monolith
- Microservices
- Event-driven architecture
- Serverless architecture

Explain the **reasoning** behind the choice.

---

## Step 3 — Define System Components

Break the system into **major services or modules**.

Example:

Authentication Service  
Farm Management Service  
Batch Tracking Service  
QR Verification Service  
Reporting Service

---

## Step 4 — Define Data Architecture

Specify:

- main databases
- storage systems
- data flow

Example:

- PostgreSQL for transactional data
- Redis for caching
- Object storage for documents

---

## Step 5 — Define External Integrations

Identify integrations such as:

- payment gateways
- authentication providers
- messaging systems
- analytics tools

---

## Step 6 — Define Core Workflows

Explain major workflows.

Examples:

- user registration
- batch creation
- QR verification

---

## Step 7 — Define Technology Stack

Recommend technologies for:

Backend  
Frontend  
Database  
Messaging  
Infrastructure

---

## Step 8 — Define Engineering Conventions

Examples:

- API standards
- coding conventions
- repository structure
- CI/CD practices

---

# Output Format

The result must follow this structure.

```
# ARCHITECTURE DESIGN

## System Overview

Description of the system.

## Architecture Style

Chosen architecture pattern and reasoning.

## System Components

List of services/modules.

Service 1
Service 2
Service 3

## Data Architecture

Main databases and storage systems.

## Core Workflows

Workflow 1
Workflow 2
Workflow 3

## Technology Stack

Backend
Frontend
Database
Infrastructure

## Deployment Architecture

Cloud infrastructure and environment.

## Engineering Conventions

API conventions
Code structure
CI/CD practices
```


---

# Quality Rules

The agent must:

- prefer **simple architectures first**
- avoid unnecessary microservices
- prioritize **maintainability**
- consider **scalability and reliability**
- ensure architecture is **implementable by the given team**

---

# Example

## System

Durian Traceability Platform

---

### Architecture Style

Modular monolith with event-driven components.

Reason:

- moderate scale
- small engineering team
- easier deployment and maintenance

---

### System Components

- Authentication module
- Farm management module
- Batch tracking module
- QR verification module
- Reporting module

---

### Data Architecture

PostgreSQL for core data  
Redis for caching  
Object storage for documents

---

### Technology Stack

Backend: Python (FastAPI)  
Frontend: React  
Database: PostgreSQL  
Cache: Redis  
Messaging: Kafka

---

### Deployment

Docker containers deployed on Kubernetes.

---

### Engineering Conventions

REST APIs  
OpenAPI documentation  
GitHub Actions CI/CD