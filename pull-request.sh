repo=`git remote -v | grep -m 1 "(push)" | sed -e 's/.*DIDIT//' -e 's/.git.*//' | sed 's/.//'`
branch=`git name-rev --name-only HEAD`
compareTo="master"
echo "... creating pull request for branch \"$branch\" and comparing to \"$compareTo\" in \"$repo\""
open https://git.uscis.dhs.gov/DIDIT/$repo/compare/$compareTo...$branch
