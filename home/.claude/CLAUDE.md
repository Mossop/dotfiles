# Important rules to follow in all projects

Most of my projects use mise to run tasks, prefer using mise tasks when available instead of npm and cargo.

Do not change directory when running tools as direnv or mise may cause you end up with unexpected environment variables in scope. Instead prefer passing target directories to commands instead of changing the directory to run the command. If changing directory is absolutely necessary, do it in a subshell.

Don't change the visibility of things in Rust without asking.
