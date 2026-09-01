# Contributing to Prime Agent

Thanks for your interest in contributing to Prime Agent! Prime Agent is developed in public, and we welcome bug reports, feature requests, questions, and other feedback. To keep the project maintainable, we ask that you follow these guidelines.

With the influx of agent-generated contributions, we do not review unsolicited pull requests or use public Issues as the initial intake queue. While we are open to contributions by agents, you are welcome to participate in the process as a human contributor.

## Start with a Discussion

Choose the category that best matches what you want to share:

- [General discussion or question](https://github.com/PrimeIntellect-ai/prime-agent/discussions/categories/general)
- [Bug report](https://github.com/PrimeIntellect-ai/prime-agent/discussions/categories/bug-reports)
- [Feature request](https://github.com/PrimeIntellect-ai/prime-agent/discussions/categories/feature-requests)

Search existing Discussions before creating a new one. Include enough detail for someone else to understand and reproduce the problem, but do not share API keys, tokens, private prompts, or other sensitive information.

For security vulnerabilities, follow [SECURITY.md](SECURITY.md) instead of posting publicly.

## Issues

GitHub Issues track work that maintainers have accepted and intend to investigate or implement. A maintainer may create an Issue from a Discussion when the scope is clear and the work fits the roadmap.

Issues opened by unapproved contributors are automatically closed and redirected to Discussions. To contribute, share interest in Discussions or corresponding issues, and maintainers can invite approved contributors.

## Pull Requests and Trusted Contributors

Prime Agent runs on user machines and can execute code with the user's permissions. We therefore limit pull requests to maintainers and trusted contributors who have been explicitly vouched for. Maintainers may open issues or discussions to invite contributions from people they trust.

Pull requests from unvouched contributors are automatically closed. If you are interested in contributing code, begin with a Discussion and work with the maintainers on the problem first.

## Preparing an Approved Pull Request

If a maintainer has invited a pull request:

1. Keep the change focused on the accepted Issue or Discussion.
2. Follow the repository's development rules and existing conventions.
3. Add or update tests for behavioral changes.
4. Run the relevant checks locally and describe the validation in the pull request.
5. Avoid unrelated refactors or dependency changes.

Development setup and commands are documented in the [development guide](packages/coding-agent/docs/development.md).

## Changelog entries

Do not edit `packages/*/CHANGELOG.md` directly. Instead, add one fragment file per PR per touched package: `packages/<pkg>/.changes/<slug>.md`, where `<slug>` is a kebab-case name derived from your branch or ticket (e.g. `eng-1234-fix-resize.md`). The file contains exactly the bullet line(s) that describe the change, e.g. `- Fixed the frobnicator dropping input on resize.`. The release script aggregates fragments into the release section and deletes them. PRs that change `packages/<pkg>/src` without a fragment fail CI; apply the `no-changelog` label to opt out.

Maintainers may close a pull request that changes scope, cannot be validated safely, or no longer fits the project roadmap.

## Quick Start for Development

```bash
# Clone repository
git clone https://github.com/PrimeIntellect-ai/prime-agent.git
cd prime-agent

# Install dependencies
npm install

# Start development
npm run dev

# Run tests
npm test

# Run linter and type checks
npm run check
```

## Commit Convention

Use conventional commits for clear commit history:
```
feat: add new feature
fix: fix a bug
chore: maintenance tasks
docs: documentation updates
perf: performance improvements
refactor: code refactoring
test: add or update tests
```

## Release Process

Semantic versioning is used for releases:

```bash
npm run release:patch   # Bug fixes (0.0.X)
npm run release:minor   # New features (0.X.0)
npm run release:major   # Breaking changes (X.0.0)
```

## Questions?

- Check [existing Discussions](https://github.com/PrimeIntellect-ai/prime-agent/discussions)
- Open a new Discussion for questions
- Report bugs via Discussion in the bug-reports category
