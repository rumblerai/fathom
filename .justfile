# Show available commands when running `just` with no arguments.
default:
    @just --list


# ---------------------------------------------------------------------------
# Environment
# ---------------------------------------------------------------------------

# Reproduce the environment exactly from the committed lockfile.
sync:
    uv sync --locked

# Explicitly refresh the lockfile after intentionally changing pyproject.toml.
lock:
    uv lock

# Deliberately upgrade locked dependencies.
upgrade:
    uv lock --upgrade


# ---------------------------------------------------------------------------
# Formatting / linting
# ---------------------------------------------------------------------------

# Apply safe Ruff fixes, including import sorting, then format.
format:
    uv run --locked ruff check --fix .
    uv run --locked ruff format .

# Non-mutating formatting check used by CI.
format-check:
    uv run --locked ruff format --check .

# Non-mutating lint check.
lint:
    uv run --locked ruff check .


# ---------------------------------------------------------------------------
# Type checking
# ---------------------------------------------------------------------------

# Fast developer feedback.
type:
    uv run --locked ty check

# Authoritative type checker used by CI.
mypy:
    uv run --locked mypy


# ---------------------------------------------------------------------------
# Tests
# ---------------------------------------------------------------------------

# Normal development test run using the project's default Python (3.14).
[positional-arguments]
test *args:
    uv run --locked pytest "$@"

# Test one Python version in a temporary environment without changing .venv.
[positional-arguments]
test-python version *args:
    version="$1"; shift; uv run --isolated --locked --python "$version" pytest "$@"

# Local compatibility sweep.
test-all:
    just test-python 3.14
    just test-python 3.15


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------

# Run the installed console-script entry point.
[positional-arguments]
run *args:
    uv run --locked fathom "$@"


# ---------------------------------------------------------------------------
# Gates
# ---------------------------------------------------------------------------

# Exactly the checks required by the main CI quality gate.
#
# ty is deliberately absent: mypy is authoritative.
check: format-check lint mypy test

# Stronger developer check including ty as well.
check-all: check type
