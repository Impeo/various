#!/bin/bash

BASE=`pwd`
repos=(efp24-data efp24-rechenkern efp24-report efp24-util eFrame efp24 efp24-business)

git clone https://github.com/Impeo/cheops.git
cd cheops
echo "# cheops" >> README.md
git add README.md
git commit -m "first commit"
git remote add origin https://github.com/Impeo/cheops.git
git push -u origin master
git branch Branch_2.1.8
git push origin Branch_2.1.8

for repo in "${repos[@]}"
do
  :
  
  cd $BASE

  echo "-> clone etvgit.etvice.intra/var/repositories/$repo.git"
  git clone ssh://tr@etvgit.etvice.intra/var/repositories/$repo.git

  cd $repo

  echo "-> checkout Branch_2.1.8"
  git checkout Branch_2.1.8
  
  echo "-> add new github remote for $repo"
  git remote add new-origin https://github.com/Impeo/cheops.git

  echo "-> remove old and rename new remote for $repo"
  git remote rm origin  
  git remote rename new-origin origin
  
  echo "-> pull from origin"
  git pull --no-edit origin Branch_2.1.8
  
  echo "-> commit just in case"
  git commit -m "merged after pull"
  
  echo "-> git push to origin"
  git push origin Branch_2.1.8
  
  echo "move all into subfolder"
  mkdir -p projects/$repo  
  find . -d 1 ! -path "./.git" ! -path "./projects" -exec git mv {} projects/$repo/ \;

  echo "-> pull from origin 2"
  git pull --no-edit origin Branch_2.1.8
  
  echo "-> commit this move"
  git commit -m "moved $repo to subfolder"
  
  echo "-> final push all"
  git push origin Branch_2.1.8 
  
done

cd $BASE
cd efp24-business

echo "-> fetch from origin to be sure we're up2date"
git fetch origin Branch_2.1.8

echo "-> merge Branch_2.1.8 into master"
git merge -s ours master
git checkout master
git merge Branch_2.1.8

echo "-> commit merge"
git commit -m "merged 2.1.8 to master"

echo "-> push merge to remote"
git push origin master

echo "-> force delete Branche_2.1.8 ... good bye for good"
git branch -D Branch_2.1.8

echo "-> and delete it remote too"
git push origin :Branch_2.1.8

echo "-> We're done... "
