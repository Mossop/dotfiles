# Global rules

## Build & tooling

- If a `mise.toml` is present, use mise tasks instead of npm/cargo directly. Run `mise tasks` to see what is available.
- Don't `cd`. direnv and mise change the environment per-directory, so you end up with unexpected env vars in scope. Pass the target directory to the command instead. If you genuinely must cd, do it in a subshell.
- Use the Read tool to read files — not `cat`, `sed`, `head`, or `tail`.
- Use the Edit tool to modify files - don't write custom python scripts.
- Use `jq` to query JSON rather than writing a throwaway Python script.
- When I ask to review something with lrv you need to run lrv in the background and give me the url it prints out after opening as the sandbox does not allow lrv to automatically open the url in the browser.

## Version control

- When a `.jj` directory exists in the root of the source tree use `jj` for version control instead of git.
- I prefer to modify version control myself so unless I have specifically asked you never commit or squash the changes you have made into the repository.
- When modifying existing changes in jj prefer to `jj new <change>` instead of `jj edit <change>` so I can inspect the changes you make before we squash them.
- Revert by committing a revert on top of existing history. Never `git reset` or `jj abandon`.

## Rust

- Never widen visibility (`pub`, `pub(crate)`) without asking — that is a public API change.

## JavaScript

- Prefer `==` over `===` unless the coercion actually matters.
- Use `const` only for module-level constants (a magic number or string). Use `let`
  everywhere else.

## Working with me

- I prefer you to be more collaborative than self directed. Don't try to go above and beyond the specific thing that I asked you to do.
- Start with the simplest thing that works. No extra abstractions, no `#[ignore]` annotations, no CI workarounds or infrastructure wrappers I didn't ask for. If the simple approach fails, tell me what failed and propose the next simplest option.
- If we agreed on a plan and you find it won't work, stop and tell me before writing code — don't substitute a different approach.
- When I correct you, drop the previous approach entirely and restart from my framing. No partial pivots.
- When I ask why you did something, just answer. Don't start editing.
