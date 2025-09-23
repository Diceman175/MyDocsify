SWP918 | Plex | Installation & Configuration Notes




Go to Control Panel > Terminal & SNMP > Terminal then enable SSH service.
Go to Control Panel > Shared Folder and create a shared folder for Git repositories.

```bash
cd cd /volume1/
cd Git
mkdir /volume1/Git/repos
cd /volume1/Git/repos
git init --bare TEC-Paradise.git

```

hint: Using 'master' as the name for the initial branch. This default branch name
hint: is subject to change. To configure the initial branch name to use in all
hint: of your new repositories, which will suppress this warning, call:
hint:
hint:   git config --global init.defaultBranch <name>
hint:
hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and
hint: 'development'. The just-created branch can be renamed via this command:
hint:
hint:   git branch -m <name>
Initialized empty Git repository in /volume1/Git/repos/



set up web service 
web poprtal;
