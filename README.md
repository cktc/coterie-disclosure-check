# coterie-disclosure-check (repository)

Source for the **CoterieLabs Disclosure Check** plugin. The plugin itself is the
[`coterie-disclosure-check/`](coterie-disclosure-check/) folder; its README is what the Claude
and OpenAI directories show. This file is for maintainers.

## Layout

| Path | What |
|---|---|
| `coterie-disclosure-check/` | The plugin: manifest, icon, skill, README, licence, changelog. Only this folder ships |
| `.claude-plugin/marketplace.json` | Lets Claude Code install from this repo before and alongside the directory listing |
| `tools/build-rules.mjs` | Regenerates the skill's `references/rules.md` from the website's checked rules |
| `tools/check-outcomes.mjs` | Confirms each coverage eval expects the outcome the website's logic gives |
| `evals/` | `claude plugin eval` cases, kept outside the plugin so they don't ship |

## The rules have one source

Every legal statement comes from `coterielabs-web/src/lib/ai-disclosure-check.ts` and
`ai-disclosure-pack.ts`, which were checked against the Act and the OAIC fact sheet. Never
edit `references/rules.md` by hand. To change a rule, change the website, then:

```bash
node --experimental-strip-types --no-warnings tools/build-rules.mjs      # needs Node 22.6+
node --experimental-strip-types --no-warnings tools/check-outcomes.mjs
claude plugin validate ./coterie-disclosure-check
claude plugin eval ./coterie-disclosure-check --eval-dir ../evals --runs 2 --judge-model sonnet
```

Both tools default to the website at `../coterielabs-web`; pass another path as the first argument.

## Releasing

1. Bump `version` in `coterie-disclosure-check/.claude-plugin/plugin.json` and add a dated
   `CHANGELOG.md` entry with the rules-review date.
2. Merge to `main`. The Claude directory scans and publishes each commit on the tracked branch.
3. OpenAI's directory needs a new upload for each version.

## Monthly upkeep

Check the OAIC's APP 1.7–1.9 pages and the Act for changes. If none, update
`DISCLOSURE_CHECK_LAST_REVIEWED` on the website, regenerate, and release a patch version so
the "rules last reviewed" date stays current.
