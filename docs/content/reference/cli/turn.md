# vlinder turn

Inspect individual turns within a session.

A turn is one user submission and all the messages it produces (invoke, requests, responses, complete).

## Subcommands

### `vlinder turn get`

Show all messages in a turn.

```
vlinder turn get <SUBMISSION_ID>
```

| Argument | Description |
|----------|-------------|
| `SUBMISSION_ID` | Submission ID of the turn to inspect |

Displays every DAG node belonging to the submission — invoke, request, response, and complete messages — in order.

## See Also

- [Domain Model](../../explanation/domain-model.md) — SubmissionId and DagNode
- [Queue System](../../explanation/queue-system.md) — message types
