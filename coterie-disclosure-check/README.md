# CoterieLabs Disclosure Check

From 10 December 2026, Australian organisations covered by the Privacy Act must say in their
privacy policy when software makes, or substantially and directly shapes, decisions about
people that could significantly affect them. The rules are Australian Privacy Principles 1.7
to 1.9. This plugin helps a business work through them in three steps:

1. **Coverage check.** Six short questions on turnover, the kind of business, and how its
   software is used, giving one of three outcomes: likely applies, likely does not apply yet,
   or check with an adviser.
2. **Decision list.** A table of the programs and tools that make or shape decisions about
   people, with the personal information each uses and whether a person makes the final call.
3. **Policy review.** Paste or attach your privacy policy. The plugin checks it against the
   three items APP 1.8 requires, names the tools it doesn't cover, and drafts wording for the
   gaps for your adviser to review.

It is written for financial advice, accounting and legal firms, and works for any business
covered by the Privacy Act.

## Install

In Claude, find **CoterieLabs Disclosure Check** in the plugin directory. In Claude Code you
can also install it from this repository:

```text
/plugin install coterie-disclosure-check --marketplace cktc/coterie-disclosure-check
```

## How to use it

Ask in plain words, for example:

- "Do the December 2026 Privacy Act AI rules apply to my business?"
- "Help me list the software that makes decisions about our clients."
- "Check our privacy policy for the new automated-decision disclosure rules." (then paste it)

## What it does with your information

Nothing leaves your conversation. The plugin is a set of written instructions and a rules
file. It runs no code, calls no servers, connects to no services and stores nothing.

## Sources

Every legal statement comes from a rules file checked against the primary sources: the
Privacy and Other Legislation Amendment Act 2024 (Cth), Schedule 1 Part 15, and the Office of
the Australian Information Commissioner's September 2026 fact sheet on APP 1.7 to 1.9. The
date the rules were last reviewed is in `CHANGELOG.md` and at the top of
`skills/ai-disclosure-check/references/rules.md`. The same rules power the web version at
[coterielabs.com.au/ai-disclosure-check](https://coterielabs.com.au/ai-disclosure-check).

## Not legal advice

The results are general information: a likely reading of your answers, not a ruling on your
business. Have your adviser review any wording before you publish it.

## Licence

[Creative Commons Attribution 4.0 International](https://creativecommons.org/licenses/by/4.0/).
You may share and adapt this plugin, including commercially, if you credit CoterieLabs and
link to the licence. Made by [CoterieLabs](https://coterielabs.com.au), Sydney.
