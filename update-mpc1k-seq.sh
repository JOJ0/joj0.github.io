#!/bin/bash
tail -n+4 ../seq/README.md > _posts/mpc1k-seq_README.md
git add _posts/mpc1k-seq_README.md 
git commit -m "mpc1k-seq_README.md update"
echo "push with:"
echo "git push"
