help:
	@echo 'MAIN USAGE: make {unshare.user, unshare.root, chroot.shell} [ROOT_DIR=<new_root>]'

# ################
# Chrooting
unshare.user_shell:
	@scripts/invoke-as.sh --unshare-user \
		$(ROOT_DIR) \
		/bin/sh
unshare.root_init:
	@scripts/invoke-as.sh --unshare-root \
		$(ROOT_DIR) \
		/init
chroot.root_shell:
	@scripts/invoke-as.sh --chroot \
		$(ROOT_DIR) \
		/bin/sh

# ################
# GIT
pull:
	@git pull
savetogit: git.pushall
	@echo '<--'
git.pushall: git.commitall
	@git push
git.commitall: git.addall
	@if [ -n "$(shell git status -s)" ] ; then git commit -m 'saving'; else echo '--- nothing to commit'; fi
git.addall:
	@git add .

