// Confirms that each coverage eval case expects the outcome the website's own evaluate()
// gives for the same answers. Run after any rules change, before trusting the evals.
//   node --experimental-strip-types --no-warnings tools/check-outcomes.mjs [path-to-coterielabs-web]
import { register } from "node:module";
import { dirname, resolve } from "node:path";
import { fileURLToPath, pathToFileURL } from "node:url";

register("./ts-resolve.mjs", import.meta.url);
const here = dirname(fileURLToPath(import.meta.url));
const web = resolve(process.argv[2] ?? resolve(here, "../../coterielabs-web"));
const { evaluate } = await import(pathToFileURL(resolve(web, "src/lib/ai-disclosure-check.ts")).href);

// Case name -> the answers its prompt describes, and the outcome its rubric expects.
const CASES = {
  "coverage-advice-firm-applies": { a: { turnover: "over", program: "yes", personal: "yes", effect: "yes", human: "key" }, expect: "likely-applies" },
  "coverage-small-bookkeeper-not-yet": { a: { turnover: "under", covered: "none" }, expect: "likely-not-yet" },
  "coverage-amlctf-only-adviser": { a: { turnover: "under", covered: "amlctf", program: "yes", personal: "yes", effect: "yes", human: "solely" }, expect: "check-adviser" },
  "coverage-drafting-only-not-yet": { a: { turnover: "over", program: "no" }, expect: "likely-not-yet" },
  "coverage-staff-only-adviser": { a: { turnover: "over", program: "yes", personal: "yes", effect: "staff", human: "key" }, expect: "check-adviser" },
};

let failed = 0;
for (const [name, c] of Object.entries(CASES)) {
  const r = evaluate(c.a);
  const ok = r.complete && r.outcome === c.expect;
  if (!ok) failed++;
  console.log(`${ok ? "ok  " : "FAIL"} ${name}: site says ${r.complete ? r.outcome : "incomplete"}, case expects ${c.expect}`);
}
if (failed) {
  console.error(`check-outcomes: ${failed} case(s) disagree with the website's evaluate()`);
  process.exit(1);
}
