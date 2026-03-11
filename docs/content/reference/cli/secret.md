# vlinder secret

Manage secrets (private keys, NKeys, API keys).

Secrets are stored in the Secret Store service. The CLI connects via gRPC.

## Subcommands

### `vlinder secret put`

Store a secret. Reads the value from stdin.

```
echo "my-secret-value" | vlinder secret put <NAME>
```

| Argument | Description |
|----------|-------------|
| `NAME` | Secret name (e.g., `agents/echo/private-key`) |

### `vlinder secret get`

Retrieve and print a secret.

```
vlinder secret get <NAME>
```

| Argument | Description |
|----------|-------------|
| `NAME` | Secret name |

### `vlinder secret delete`

Delete a secret.

```
vlinder secret delete <NAME>
```

| Argument | Description |
|----------|-------------|
| `NAME` | Secret name |

### `vlinder secret exists`

Check if a secret exists. Exits with code 0 if found, 1 if not.

```
vlinder secret exists <NAME>
```

| Argument | Description |
|----------|-------------|
| `NAME` | Secret name |

## See Also

- [Agents Model](../../explanation/agents-model.md) — agent identity and Ed25519 keys
- [Architecture](../../explanation/architecture.md) — Secret Store worker
