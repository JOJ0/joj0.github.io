#!/bin/bash
echo Copying gist md file...
tail -n+4 ../git-essentials/J0J0s_Git_Essentials.md > _posts/git-essentials-gist.md

if [ "$1" = "doit"  ]; then
  echo "commiting and pushing..."
  git add _posts/git-essentials-gist.md 
  git commit -m "git-essentials-gist.md update"
  git push
else
  echo "to also commit and push, add argument \"doit\""
fi
