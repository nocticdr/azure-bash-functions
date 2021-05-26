# Git Fast
#This function is to do a git add, git commit and git push, all in one line/command.
gfast() 
{
  comment=$1
  git add .;git commit -s -m "$comment";git push --set-upstream origin $(git_current_branch)
}

# Git Extra Fast
#This function is to do a create a git branch, do a git add, git commit and git push, all in one line/command.
gxf() 
{
  branchname=$1
  comment=$2
  git checkout -b $branchname; git add .;git commit -s -m "$comment";git push --set-upstream origin $(git_current_branch)
}