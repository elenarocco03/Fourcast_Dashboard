File for the agent (Claude, Codex)

- keep the code simple and human-readable
- keep the code flexible enough to wire it in the dashboard, even if the user asks you to compute the method on a fixed sample
- use as reference for theory and notation the material in /theory

## Project journal (report/JOURNAL.md)

The journal is the raw material for the final report. Keep it up to date without being asked.

- **When:** before every commit that reaches `main` (a commit on `main`, or a merge or push
  of another branch into `main`), add or extend the journal entry and put
  `report/JOURNAL.md` in the same commit. Create the file from its template if it is
  missing. Commits on other branches do not need it, but the merge into `main` does.
- **One entry per author and working day**, appended at the bottom. If an entry with the
  same date and author exists, extend it instead of adding a new one.
- **Content: results and reasons, not the discussion.** Write what was done, the decisions
  with the alternative and the reason (the reasons usually come from the conversation with
  the user), the limitations found, and the open points. Leave out debugging history and
  the steps of the discussion.
- **Numbers only from running our code.** Say so when a number comes from an exploratory
  script outside the repository.
- **Never invent a reason.** If the reason for a choice is unknown, write
  `[TODO: ask <author>]`.
- English, concise, using the template at the top of the journal.
- A git pre-commit hook (`.githooks/pre-commit`) and a GitHub check
  (`.github/workflows/journal-check.yml`) verify that the journal changed. With Claude Code,
  `/journal` writes the entry.
