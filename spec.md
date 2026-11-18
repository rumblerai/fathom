# Fathom CLI To Extract Meetings

Write a Python cli that fetches paginated data from the Fathom AI API and streams the individual records to standard output (`stdout`) as JSON Lines (JSONL) so the output can be piped directly into downstream Bash tools.

Use the Fathom Python SDK - reference the online API docs where required.

### API & Pagination Details

Endpoint, authentication, pagination mechanism and records location should all be handled by the SDK. Confirm this.

### Streaming & Output Requirements
1. **JSONL Format:** Iterate through the records on each page as soon as the page is fetched. Serialize each individual record as a single-line, compact JSON object (`json.dumps(record, separators=(",", ":"))`) and print it to `stdout`. Do not accumulate all pages in memory before printing.
2. **Buffer Flushing:** Call `sys.stdout.flush()` at the end of processing each page so downstream Bash commands receive data immediately without waiting for Python's block buffer to fill.
3. **Stream Separation:** Send all progress updates, debug logs, rate-limit notices, and error messages strictly to `stderr` (e.g., using `sys.stderr` or Python's `logging` module) so `stdout` remains pure, valid JSONL.
4. **Error & Pipe Handling:** Gracefully catch `BrokenPipeError` (for example, if the script is piped into `| head`) and exit cleanly with code `0` without printing a traceback. Include basic HTTP error handling (`raise_for_status()`) and retry logic for rate limits (`429`) or transient server errors.


### Architecture

Use python Protocol and dependency injection of client into high level functions to make testing and mocking straightforward.

Use a fake client for tests and consider the use of SimpleNamespace for test data if appropriate.

### Implementation

Use `click` library for the CLI and the Fathom Python SDK for accessing the API.

### Development

Follow test driven development, writing tests ahead of implementation. At each step, modify local files and follow the appropraite dev process for the code base.  I am using git. Ask me to approve each step before starting the next. When approval is received, commit the changes, confirm that the commit succeeded and if it does, do the next step.
