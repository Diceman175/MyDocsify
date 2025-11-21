# Git and Git Flow Cheat Sheet <!-- omit from toc -->

[![Awesome](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)](https://github.com/sindresorhus/awesome) This comprehensive Git cheat sheet helps you master Git commands without memorizing everything. Whether you're a beginner or an experienced developer, this guide provides quick reference to essential Git operations.

## 🔧 Setup

### View Configuration

- Run `git config --list` # **Show current configuration:**
- Run `git config --local --list` ## **Show repository configuration:**
- Run `git config --global --list` ### **Show global configuration:**
- Run `git config --system --list` #### **Show system configuration:**

### User Configuration

- Run `git config --global user.name "[firstname lastname]"` ##### **Set your name for version history:**
- Run `git config --global user.email "[valid-email]"` ###### **Set your email address:**

### Display & Editor Settings

- Run `git config --global color.ui auto` **Enable automatic command line coloring:**
- Run `git config --global core.editor vi` **Set global editor for commits:**
---

## ⚙️ Configuration Files

| Scope              | Location              | Command Flag |
|--------------------|-----------------------|--------------|
| **Repository**     | `<repo>/$$git/config` | `--local`    |
| **User**           | `~/gitconfig`         | `--global`   |
| **System**         | `/etc/gitconfig`      | `--system` |

---

## 🆕 Create Repository

### Clone Existing Repository

- Run `git clone ssh://user@domain.com/repo.git` **Via SSH:**
- Run `git clone https://domain.com/user/repo.git` **Via HTTPS:**

### Initialize New Repository

- Run `git init` **Create repository in current directory:**
- Run `git init <directory>` **Create repository in specific directory:**

---

## 📝 Local Changes

### Check Status & Differences

- Run `git status` **View working directory status:**
- Run `git diff` **Show changes to tracked files:**
- Run `git diff <file>` **Show changes in specific file:**

### Staging Changes

- Run `git add .` **Add all current changes:**
- Run `git add <filename1> <filename2>` **Add specific files:**
- Run `git add -p <file>` **Interactively add parts of a file:**

### Committing Changes

- Run `git commit -a` **Commit all tracked file changes:**
- Run `git commit` **Commit staged changes:**
- Run `git commit -m 'message here'` **Commit with message:**
- Run `git commit -am 'message here'` **Skip staging and commit with message:**
- Run `git commit --date="`date --date='n day ago'`" -am "<Commit Message Here>"` **Commit with specific date:**

### Modify Last Commit

> ⚠️ ` **Warning:** Don't amend published commits!

- Run `git commit -a --amend` **Amend last commit:**
- Run `git commit --amend --no-edit` **Amend without changing commit message:**
- Run `git_COMMITTER_DATE="date" git commit --amend` **Change committer date:**
- Run `git commit --amend --date="date"` **Change author date:**

### Stashing Changes

- Run `git stash` **Save current changes temporarily:**
- Run `git stash apply` **Apply last stashed changes:**
- Run `git stash apply stash@{stash_number}` **Apply specific stash:**
- Run `git stash list` **to see available stashes**
- Run `git stash drop` **Remove last stash:**

**Move uncommitted changes to another branch:**

```bash
git stash
git checkout branch2
git stash pop
```

---

## 🔍 Search

### Text Search

- Run `git grep "Hello"` **Search for text in all files:**
- Run `git grep "Hello" v2.5` **Search in specific version:**

### Commit Search

- Run `git log -S 'keyword'` **Find commits that introduced specific keyword:**
- Run `git log -S 'keyword' --pickaxe-regex` **Search with regular expression:**

---

## 📖 Commit History

### Basic History

- Run `git log` **Show all commits (detailed):**
- Run `git log --oneline` **Show commits (one line each):**
- Run `git log --author="username"` **Show commits by specific author:**
- Run `git log -p <file>` **Show changes for specific file:**

### Advanced History

- Run `git log --oneline <origin/master>..<remote/master> --left-right` **Compare branches:**
- Run `git blame <file>` **Show who changed what and when:**

### Reference Logs

- Run `git reflog show` **Show reference log:**
- Run `git reflog delete` **Delete reference log:**

---

## 📁 Move / Rename

- Run `git mv Index.txt Index.html` **Rename a file:**

---

## 🌿 Branches & Tags

### List Branches

- Run `git branch` **List local branches:**
- Run `git branch -a` **List all branches (local + remote):**
- Run `git branch -r` **List remote branches:**
- Run `git branch --merged` **List merged branches:**

### Switch & Create Branches

- Run `git checkout <branch>` **Switch to existing branch:**
- Run `git checkout -b <branch>` **Create and switch to new branch:**
- Run `git checkout -` **Switch to previous branch:**
- Run `git checkout -b <new_branch> <existing_branch>` **Create branch from existing branch:**
- Run `git checkout <commit-hash> -b <new_branch_name>` **Create branch from specific commit:**
- Run `git branch <new-branch>` **Create branch without switching:**
- Run `git branch --track <new-branch> <remote-branch>` **Create tracking branch:**

### Branch Operations

- Run `git checkout <branch> -- <filename>` **Checkout single file from different branch:**
- Run `git cherry-pick <commit hash>` **Apply specific commit from another branch:**
- Run `git branch -m <new_branch_name>` **Rename current branch:**
- Run `git branch -d <branch>` **Delete local branch:**
- Run `git branch -D <branch>` **Force delete local branch:**

> ⚠️ ` **Warning:** You will lose unmerged changes!

### Tags

- Run `git tag <tag-name>` **Create tag at HEAD:**
- Run `git tag -a <tag-name>` **Create annotated tag:**
- Run `git tag <tag-name> -am 'message here'` **Create tag with message:**
- Run `git tag` **List all tags:**
- Run `git tag -n` **List tags with messages:**

---

## 🔄 Update & Publish

### Remote Management

- Run `git remote -v` **List configured remotes:**
- Run `git remote show <remote>` **Show remote information:**
- Run `git remote add <remote> <url>` **Add new remote:**
- Run `git remote rename <remote> <new_remote>` **Rename remote:**
- Run `git remote rm <remote>` **Remove remote:**

> ℹ️ ` **Note:** This only removes the remote reference locally, not the remote repository itself.

### Fetch & Pull

- Run `git fetch <remote>` **Download changes without merging:**
- Run `git pull <remote> <branch>` **Download and merge changes:**
- Run `git pull origin master` **Get changes from main branch:**
- Run `git pull --rebase <remote> <branch>` **Pull with rebase:**

### Push & Publish

- Run `git push <remote> <branch>` **Publish local changes:**
- Run `git push <remote> --delete <branch>` **Delete remote branch:** on git v1.7.0+
- Run `git push <remote> :<branch>` **Delete remote branch:** on git v1.5.0+
- Run `git push --tags` **Publish tags:**

---

## 🔀 Merge & Rebase

### Merge Operations

- Run `git merge <branch>` **Merge branch into current HEAD:**
- Run `git config --global merge.tool meld` **Configure merge tool globally:**
- Run `git mergetool` **Use configured merge tool:**

### Rebase Operations

> ⚠️ ` **Warning:** Don't rebase published commits!

- Run `git rebase <branch>` **Rebase current HEAD onto branch:**
- Run `git rebase --abort` **Abort rebase:**
- Run `git rebase --continue` **Continue rebase after resolving conflicts:**

### Conflict Resolution

- Run `git add <resolved-file>` **Mark file as resolved:**
- Run `git rm <resolved-file>` **Remove resolved file:**

### Squashing Commits

- Run `git rebase -i <commit-just-before-first>` **Interactive rebase for squashing:**

**Example squash configuration:**

```bash
> Before
>pick <commit_id>
>pick <commit_id2>
>pick <commit_id3>
> After (squash commit_id2 and commit_id3 into commit_id)
>pick <commit_id>
>squash <commit_id2>
>squash <commit_id3>
```

---

## ↩️ Undo

### Discard Changes

- Run `git reset --hard HEAD` **Discard all local changes:**
- Run `git reset HEAD` **Unstage all files:**
- Run `git checkout HEAD <file>` **Discard changes in specific file:**

### Reset Operations

- Run `git reset --hard <commit>` **Reset to previous commit (discard all changes):**
- Run `git reset --hard <remote/branch>` **Reset to remote branch state:**

>Example: - Run `git reset --hard upstream/master`

- Run `git reset <commit>` **Reset preserving changes as unstaged:**
- Run `git reset --keep <commit>` **Reset preserving uncommitted local changes:**

### Revert Commits

- Run `git revert <commit>` **Revert commit (create new commit with opposite changes):**

### Clean Ignored Files

**Remove accidentally committed files that should be ignored:**

```bash
git rm -r --cached .
git add .
git commit -m "remove ignored files"
```

