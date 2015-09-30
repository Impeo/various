#!/bin/bash

BASE=`pwd`
new_repo=cheops
#repos=( efp24-data efp24-rechenkern efp24-report efp24-util eFrame efp24 efp24-business)
repos=(efp24-report efp24-util)

for repo in "${repos[@]}"
do
  :

  cd $BASE/$new_repo

  echo "start merging $repo"
  
  git remote add -f $repo ssh://tr@etvgit.etvice.intra/var/repositories/$repo.git

  git merge $repo/Branch_2.1.8

  git commit -m "merged $repo to new master"
  
  mkdir $repo

  find . -d 1 ! -regex '\(.*\/\.git\)' -exec git mv {} $repo/ \;
  
  git commit -m "moved $repo to folder"
done

echo "done"





