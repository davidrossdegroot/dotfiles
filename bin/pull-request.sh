repo=`git remote -v | grep -m 1 "(push)" | sed -e 's/.*davidrossdegroot//' -e 's/.git.*//' | sed 's/.//'`
branch=`git name-rev --name-only HEAD`
compareTo="main"
echo "... creating pull request for branch \"$branch\" and comparing to \"$compareTo\" in \"$repo\""
open https://github.com/davidrossdegroot/$repo/compare/$compareTo...$branch
