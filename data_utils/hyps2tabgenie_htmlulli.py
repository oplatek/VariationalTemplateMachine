#!/usr/bin/env python
import sys

hyp_file = sys.argv[1]

with open(hyp_file, "rt") as r:
    egs = r.read().split("\n\n")
    egs_hyps = [e.split("\n") for e in egs]

for eh in egs_hyps:
    hyp_html = " ".join([f"<li>{h}</li>" for h in eh])
    print(f"<ul>{hyp_html}</ul>")
