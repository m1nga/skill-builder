# Minimal continuity with work-memory

Use this only when a task needs a session boundary or a meaningful recovery checkpoint.
Locate the installed work-memory skill through the host's skill catalog; read its command
reference rather than guessing command flags. No scheduler or new memory engine is needed.

## Prepare in the original session

1. Select the actual project root. Use its existing store/binding and original case records.
   Initialize/register a store only when ongoing work merits continuity. A multi-project
   chat requires separate project records; do not blend them into one global packet.
2. Use `memory.py status --root ROOT` and a relevant
   `memory.py recall --root ROOT --query QUERY --limit 2 --brief`. Inspect relevant receipt
   gaps only when the corresponding source/work can be checked. An unseen gap stays open.
3. Capture changed decisions/facts/open items with their source and authority. Reuse records
   already captured; updating a key requires its current revision. Keep credentials, private
   transcripts and unrelated project facts out of the packet.
4. Save a compact handoff in an existing private case/work record when possible. If a new
   file is needed, use the project's authorized private work area, not the public skill.
   If there is no authorized private file destination, deliver it in the current chat.
5. Run `memory.py checkpoint --root ROOT --input INPUT_JSON` with the actual available turn
   key, or an explicitly labeled logical key. Check exit code and JSON `ok`; save returned
   IDs. Use `no_change:true` and no record IDs only when no meaningful delta was saved.

The packet should be small enough to read at task entry:

```text
Root / task identity:
Goal and current user constraints:
Authoritative files or URLs with version/date:
Disposition, observed symptoms, and repair result (or unknown):
Verified completed work with evidence:
Open work, original owner/case, in-flight action IDs and unknown results:
Applicable permissions, holds and safe migration boundary:
Superseded/rejected assumptions (clearly excluded from current facts):
Relevant memory record IDs and checkpoint receipt/key (or missing):
Next concrete action and its verification:
```

A packet says what is needed, not everything discussed. Link large artifacts and read only
what the next action needs. It must remain understandable without the old chat. Never
claim a complete historical recovery; omissions and unverified results must stay explicit.

## Consume in the receiving session

- Read the current user instruction and root-level rules, then verify packet root/task and
  authoritative sources. Resolve changed versions before adopting the old plan.
- Run bounded recall against that same store; preserve source/authority distinctions.
  Do not replay the entire old transcript or import rejected approaches as instructions.
- Check original records for in-flight actions before acting. An external request with an
  unknown outcome is a verification task, never a fresh send. Retain the original owner
  and account; handoff text alone does not authorize taking over a live run.
- Perform the next authorized step and verify its result. A stopped task remains stopped;
  an unresolved dependency can be a successful recovery of state without a new action.
- Checkpoint the actual recovery result. If testing a trial/active lesson, use work-memory's
  real `use`/`observe` lifecycle. Otherwise record facts/open items, not invented learning.

Packet written, checkpoint accepted, host loaded, and continuation observed are distinct
states. A readback proves receipt/retrieval, not that another session can reason correctly.

## Host adoption

For a request to apply this across tasks, add a short pointer to each actually supported
host's existing global instruction file, preserving other configuration. The pointer asks
for a lightweight check at task entry, meaningful corrections and task changes; load this
skill only when the assessment needs it. Do not install timers, polling hooks, transcript
crawlers, or bulk messages to existing chats. Use actual installed paths locally; public
instructions contain no machine-specific usernames or work records.

Validate local discovery paths and reload/entry behavior only where observable. Existing
sessions, remote machines and other accounts may need their own host reload or setup;
list these limits without claiming universal activation from a filesystem edit.
