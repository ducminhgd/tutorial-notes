# Project instructions

## Principal

1. Simplicity first: make the changes as simple as possible.
2. No laziness: find the root cause, no temporary fixes, fix it properly as Senior level.

## Task management and workflow

1. Plan first: `ai/planning/project.md` and `ai/planning/<task>.md`
2. Verify the plan.
3. Implement: `ai/implementation/<task>.md`
4. Do Quality Assurance.
5. Tracking progress: mark a task as complete when it's done.
6. Capture lessons: `ai/rules/lesson.md`
7. If there is any suggested side-work, note it down in `ai/suggestions/<summary>.md`

## Planning mode

1. Planning files are in `ai/planning/` directory.
   1. `ai/planning/project.md` for project-level planning
   2. `ai/planning/<task>.md` for task-level planning
2. If something goes sideways, STOP and re-plan immediately, don't keep pushing.
3. Write detail specs upfront to reduce ambiguity 

## Self-improvement

1. After ANY correction from the user, update `ai/rules/lesson.md` to prevent future mistakes, with this pattern:
   1. Write rules for yourself that prevent the same mistake
   2. Rutelessly iterate on these lessons until mistake rate drops.
   3. Reivew the lessons at the session start.

## Quality Assurance

1. NEVER mark a task complete until you can prove it works.
2. Ask yourself: "Will a Staff Engineer approve this work?".
3. Run tests, check logs, demotrate correctness.