---
description: Add or extend today's entry in report/JOURNAL.md (results, decisions and reasons, limitations, open points)
---

Update the project journal `report/JOURNAL.md` following the "Project journal" rules in
`AGENT.md` and the template at the top of the journal.

1. Find out the author (`git config user.name`), today's date and the commits of this
   working session (`git log`, plus any staged changes).
2. If an entry with today's date and this author exists, extend it; otherwise append a new
   entry at the bottom.
3. Fill it from this conversation and the code: what was done, each decision with its
   alternative and its reason, numbers produced by our code, limitations, open points.
   Results and reasons only, not the discussion. Never invent a reason: write
   `[TODO: ask <author>]` when it is unknown.
4. Stage the file (`git add report/JOURNAL.md`) and show the user the entry you wrote.
   Do not commit unless the user asked for it.

$ARGUMENTS
