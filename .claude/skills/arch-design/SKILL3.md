---
skill_id: architecture-design
version: 1.0.0
category: Engineering & System Design
tags: [c4-model, tech-stack, system-design, coding-standards, cloud-native]
complexity: High
description: >
  Use this skill when the user wants to design system architecture, choose a technology stack, define coding conventions, create architecture diagrams, or map out system workflows and data flows. Trigger whenever the user says things like "design the architecture for", "what tech stack should I use", "how should I structure this system", "draw a diagram for", "design a microservice", "how should modules communicate", "what pattern should I use for", "design the database schema", "design an API", or asks how to architect any software system end-to-end. Also trigger when the user shares a PRD or project plan and wants the technical design, or asks to review/critique an existing architecture. This skill covers system design, component breakdown, tech stack selection, coding conventions, and Mermaid/PlantUML diagrams.
---

# Skill: Architecture Design & Technical Leadership

## Description
This skill enables the AI agent to act as a Lead System Architect. It translates product requirements into a technical blueprint, defining how data flows, how services interact, and which technologies are best suited for the specific constraints of the project.

## Capabilities
* **System Modeling:** Generate diagrams following the **C4 Model** (Context, Containers, Components, Code) or standard UML.
* **Stack Selection:** Recommend the optimal **Technology Stack** (e.g., Go vs. Python, PostgreSQL vs. NoSQL) based on performance and scalability needs.
* **API & Workflow Design:** Define RESTful or gRPC contracts, message queue patterns (e.g., RabbitMQ/Kafka), and database schemas.
* **Standardization:** Establish **Coding Conventions**, directory structures, and CI/CD pipeline strategies.
* **Infrastructure Design:** Outline cloud-native patterns (Docker, Kubernetes, Serverless) and security protocols (OAuth2, TLS).

## Input Format
* **Product Scope:** Output from the "Project Planning" skill.
* **Non-Functional Requirements:** Throughput (RPS), Latency targets, Data residency, and Security needs.
* **Existing Ecosystem:** List of current tools or legacy systems to integrate with.

## Output Format
* **Architecture Decision Records (ADRs):** Justification for chosen technologies.
* **Workflow Diagrams:** Visual or Mermaid-based sequence and ER diagrams.
* **Directory Structure:** A boilerplate folder hierarchy for the backend repository.
* **Data Model:** Entity Relationship Diagram (ERD) or Schema definitions (SQL/NoSQL).

## Best Practices
* Optimize for the "Rule of Least Power"—don't over-engineer with microservices if a monolith suffices.
* Always prioritize "Observability" (Logging, Tracing, Metrics) in the initial design.
* Ensure the design adheres to SOLID principles and Clean Architecture patterns.