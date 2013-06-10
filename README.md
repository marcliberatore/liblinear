liblinear
=========

A library for large linear classification, forked from

http://www.csie.ntu.edu.tw/~cjlin/liblinear/

Why Fork?
---------

I needed to make source-level modifications. In particular, I wanted to optimize parameters using measures other than accuracy. The current version uses F-Score: 2 * Precision * Recall / (Precision + Recall).


Additional Documentation
------------------------

1. Note the current Makefile is tweaked for OS X. Use `Makefile.orig` if you're on another unix-style OS.

2. See README for more details.
