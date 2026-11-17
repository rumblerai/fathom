"""Tests for the CLI."""

import pytest

from fathom import main


def test_main() -> None:
    """Basic CLI test."""
    assert main(None) == 0


def test_main_with_args(capsys: pytest.CaptureFixture) -> None:
    """Show help.

    Parameters:
        capsys: Pytest fixture to capture output.
    """
    exit_code = main(["say", "--quiet"])
    assert exit_code == 0
    captured = capsys.readouterr()
    assert "['say', '--quiet']" in captured.out
