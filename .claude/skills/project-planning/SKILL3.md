---
skill_id: project-planning
version: 1.0.0
category: Project Management
tags:
  - project-planning
  - product-management
  - agile
  - software-development
  - task-breakdown
complexity: High
---

# Skill: Project Planning & Backlog Engineering

## Description
This skill enables the AI agent to decompose a product vision into a hierarchical execution plan. It focuses on logical dependencies, resource allocation, and clear task definition for engineering teams.

## Capabilities
* **WBS Generation:** Create a **Work Breakdown Structure** from Epic level down to Sub-tasks.
* **Dependency Mapping:** Identify "blockers" and critical path items (e.g., Database Schema must precede API development).
* **Technical Estimation:** Suggest complexity scores (Story Points) or time-to-complete based on historical industry benchmarks.
* **Sprint Definition:** Organize tasks into logical milestones or Sprints (MVP vs. Phase 1).
* **Risk Assessment:** Flag potential bottlenecks (e.g., third-party API integration risks).

## Input Format
* **PRD/Feature List:** Output from the "Product Ideation" skill.
* **Team Capacity:** Number of developers, tech stack, and timeline.
* **Methodology:** (e.g., Agile/Scrum, Waterfall, or Kanban).

## Output Format
* **Project Roadmap:** High-level timeline of Epics.
* **Backlog Table:** | Type | Title | Description | Dependency | Priority |
    | :--- | :--- | :--- | :--- | :--- |
    | Epic | User Auth | End-to-end authentication system | None | P0 |
    | Task | JWT Setup | Implement RS256 signing logic | Auth Epic | P0 |
* **Milestone Checklist:** Definition of Done (DoD) for each major phase.

## Best Practices
* Keep tasks "Atomic" (one task = one specific outcome).
* Ensure every task has a clear "Definition of Done".
* Account for "Buffer" time for testing and CI/CD pipelines.