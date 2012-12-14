#! /bin/bash
for branch in `git branch -a | sed -n '\=/HEAD$-d; \=/master$=d;s=<SPACE><SPACE>remotes/==p'`; do
	git branch --track ${branch##*} $branch
done

