---
tags:
  - prog
  - uni
---
##### merging
* `git merge <branch name>` - you have to be on another branch `git checkout` and merge the other one INTO yours.
* `git rebase <to where> <from where>`- Take commits from branch and puts them into another one. Will look as if the whole project was written in one branch. Will place commit AFTER the head of branch you chose.
	* `-i <branch name>` - interactive layout for managing commits
	
> `git pull` is just shorthand for a fetch and a merge. Conveniently enough, `git pull --rebase` is shorthand for a fetch and a rebase!

##### relative refs
used with `git checkout`
upwards = back (up the tree, closer to the root)
 - Moving upwards one commit at a time with `^<num>`. 
 - Moving upwards a number of times with `~<num>`
 - num is optional. default = 1
 can stack these like so: `git checkout HEAD~^2~2`. 
 1) move up once
 2) choose second parent (have two parents as if two diff branches that were merged)
 3) move up that branch twice
 ![[Pasted image 20250420232219.png]]
 

##### branch forcing
 - `git branch -f <move what branch> <where>`

- `git branch -f main HEAD~3`
moves (by force) the main branch to three parents behind HEAD.
use relative refs OR hash commits
*its basically checking out WITH the branch itself, instead of detaching head and moving*
> In a real git environment `git branch -f command` is not allowed for your current branch.

##### reverting
* `git reset <what branch or HEAD to which to reset to>` will move a branch backwards as if the commit had never been made in the first place. Used for LOCAL machine usually.
- `git revert <what branch or HEAD to revert>` In order to reverse changes and _share_ those reversed changes with others, we need to use `git revert`.  Used for REMOTE machines usually.
##### cherry-pick
- `git cherry-pick <Commit1> <Commit2> <...>`
It's a very straightforward way of saying that you would like to copy a series of commits below your current location (`HEAD`).
##### change last commit
`git commit --amend` command allows you to modify the most recent commit, including changing its message or adding new changes. This command effectively replaces the last commit with a new one that includes your updates.

##### git tags
`git tag <name of the tag> <which commit>`
simple af

##### understanding where you are
`git log` `git log --graph` - shows the log of commits of current branch

`git describe <ref>` - Where `<ref>` is anything git can resolve into a commit. If you don't specify a ref, git just uses where you're checked out right now (`HEAD`).
The output of the command looks like:
`<tag>_<numCommits>_g<hash>`
Where `tag` is the closest ancestor tag in history, `numCommits` is how many commits away that tag is, and `<hash>` is the hash of the commit being described.

##### tracking remote branch
To create your own branch that would track remote branch use
`git branch <your branch> <remote branch>`, for example
`git checkout -b totallyNotMain o/main` - Creates a new branch named `totallyNotMain` and sets it to track `o/main`.

Another way to set remote tracking on a branch is to simply use the `git branch -u` option. Running
`git branch -u o/main foo`
will set the `foo` branch to track `o/main`. If `foo` is currently checked out you can even leave it off:
`git branch -u o/main`

##### push
git push can optionally take arguments in the form of:
`git push <remote> <place>`

`git push origin main`
translates to this in English:
_Go to the branch named "main" in my repository, grab all the commits, and then go to the branch "main" on the remote named "origin". Place whatever commits are missing on that branch and then tell me when you're done._
By specifying `main` as the "place" argument, we told git where the commits will _come from_ and where the commits _will go_. It's essentially the "place" or "location" to synchronize between the two repositories.
Keep in mind that since we told git everything it needs to know (by specifying both arguments), it totally ignores where we are checked out!

`git push origin <source>:<destination>`
Is used for pushing from local branch onto another (differently called) remote branch, like so:
`git push origin foo^:main`
or even push to a branch that doesn’t exist (it will create it)
`git push origin main:newBranch`
