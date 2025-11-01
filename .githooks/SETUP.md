# Git Hooks Setup

These hooks help maintain code quality by checking before commits and pushes.

## Setup (One Time)

```bash
# Configure Git to use .githooks directory
git config core.hooksPath .githooks

# Make hooks executable
chmod +x .githooks/pre-commit
chmod +x .githooks/pre-push

# Verify setup
git config core.hooksPath
```

## Hooks Included

### pre-commit
Runs BEFORE committing, checks:
- ❌ No TODO comments in code
- ❌ No console.log statements
- ❌ No merge conflicts
- ⚠️  Large files (>10MB)

### pre-push
Runs BEFORE pushing, checks:
- ✓ Tests pass
- ⚠️  FIXME/HACK comments

## To Skip Hooks

If you need to bypass for emergency:

```bash
# Skip pre-commit
git commit --no-verify

# Skip pre-push
git push --no-verify
```

**⚠️  Only use when absolutely necessary.**

## Testing Hooks Locally

```bash
# Run pre-commit manually
.githooks/pre-commit

# Run pre-push manually
.githooks/pre-push
```

## Update Hooks

Edit the hook files in `.githooks/` and commit.

Hooks automatically run on `git commit` and `git push`.

