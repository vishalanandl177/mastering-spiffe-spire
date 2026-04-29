# Contributing to Mastering SPIFFE & SPIRE

Thank you for your interest in improving this free course!

## How to Contribute

### Report a Bug

Open an issue describing:
- The lab and step where you encountered the bug
- What you expected vs. what happened
- Your environment (OS, Docker version, etc.)
- Steps to reproduce

### Suggest an Improvement

Open an issue with the `enhancement` label. Examples:
- Additional lab scenarios
- Alternative approaches to existing labs
- Better explanations
- New integrations (tools, frameworks)

### Submit a Pull Request

1. Fork this repository
2. Create a feature branch: `git checkout -b improve-module-5-debugging`
3. Make your changes
4. Test all affected labs
5. Commit with descriptive messages
6. Push and open a PR

## Lab Contribution Guidelines

When adding or modifying labs:

- **Idempotent setup scripts** — should be safe to run multiple times
- **Clear cleanup instructions** — every lab needs a way to undo
- **No hardcoded secrets** — use environment variables or generated certs
- **Comments in scripts** — explain what each section does
- **Work on a fresh Kind cluster** — labs should not depend on each other unless explicitly stated

## Documentation Style

- Use clear, simple language
- Include code examples for every concept
- Link to external docs (SPIFFE.io, K8s docs) where appropriate
- Keep instructions copy-paste-able

## Code of Conduct

Be respectful and inclusive. This is a learning resource — help others learn rather than gatekeep.

## Questions?

Open a discussion or reach out at [coderssecret.com/consultation](https://coderssecret.com/consultation).
