#!/usr/bin/env bash
xelatex -shell-escape main
bibtex main
xelatex -shell-escape main
xelatex -shell-escape main
