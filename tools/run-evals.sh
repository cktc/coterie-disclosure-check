#!/bin/bash
# Runs the eval suite against a temporary copy of the plugin with evals/ placed inside it.
# claude plugin eval only reads cases from inside the plugin folder, and the cases must not
# ship with the plugin, so they live at the repo root and are copied in for each run.
# Extra arguments pass through to claude plugin eval, e.g. --case 'policy-*' --runs 1
set -euo pipefail
repo="$(cd "$(dirname "$0")/.." && pwd)"
work="$(mktemp -d "${TMPDIR:-/tmp}/disclosure-evals.XXXXXX")"
cp -R "$repo/coterie-disclosure-check" "$work/plugin"
cp -R "$repo/evals" "$work/plugin/evals"
echo "run-evals: working copy at $work/plugin"
claude plugin eval "$work/plugin" --trust-plugin --judge-model sonnet \
  --report "$repo/evals-report.html" --json "$repo/evals-result.json" "$@"
