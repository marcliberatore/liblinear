liblinear
=========

A library for large linear classification, forked from

http://www.csie.ntu.edu.tw/~cjlin/liblinear/

Why Fork?
---------

I needed to make source-level modifications. In particular, I wanted to optimize parameters using measures other than accuracy. The current version uses F-Score: 2 * Precision * Recall / (Precision + Recall).


Additional Documentation
------------------------

1. The problem described by the input must be a binary classification problem, and class labels must be either `+1` or `-1`.

1. Modify the assigned value of `validation_function` in `eval.cpp` to change the evaluation function.

1. Note the current Makefile is tweaked for OS X. Use `Makefile.orig` if you're on another unix-style OS.

1. See README for more details.
