import sys


def main(args: list[str] | None = None) -> int:
    """Run the main program.

    This function is executed when you type `fathom` or `python -m fathom`.

    Parameters:
        args: Arguments passed from the command line.

    Returns:
        An exit code.
    """
    # Normalize right away to catch calls from the entry point wrapper
    if args is None:
        args = sys.argv[1:]

    print(args)
    return 0
