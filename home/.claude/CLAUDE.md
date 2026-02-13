# Important rules to follow in all projects

Most projects use mise to run tasks, prefer using mise tasks when available instead of npm and cargo.

Do not change directory when running tools as direnv or mise may cause you end up with unexpected environment variables in scope. Instead prefer passing target directories to commands instead of changing the directory to run the command. If changing directory is absolutely necessary, do it in a subshell.

DO NOT change the visibility of things in Rust without asking.

When the user asks a question about why you took a particular approach just explain why. The user may agree with your reasoning. DO NOT start to make changes unless explicitly asked.

When implementing a fix or feature, start with the simplest possible approach. Do not over-engineer solutions, add unnecessary abstractions, or introduce extra code (like #[ignore] annotations, CI workarounds, or infrastructure wrappers) that the user didn't ask for. If the first approach doesn't work, explain what failed and propose the next simplest option.

When you encounter an issue with the agreed-upon approach, DO NOT silently switch to a different approach. Stop and tell the user what went wrong and propose alternatives. Never silently change the implementation strategy.

When the user redirects your approach or corrects your understanding of the problem, fully stop the current approach, acknowledge the correction, and restart from the user's framing. Do not continue pushing the previous approach or make partial pivots.

Don't use sed, use your normal Edit tool
