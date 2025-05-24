#!/bin/bash
set -e
ROOT_DIR_PATH="$2"
CMD="$3"

# #########################
# MAIN logic
echo
echo '# ################# #'
echo '# [ ENTERING ROOT ] #'

case $1 in
	--chroot)
		sudo -k env -i \
			/sbin/chroot "$ROOT_DIR_PATH" "$CMD"
		;;

	--unshare-root)
		sudo -k env -i \
			unshare --fork \
				--mount --uts --ipc --net --pid --mount-proc \
				--root="$ROOT_DIR_PATH" \
				"$CMD"
		;;

	--unshare-user)
		env -i \
			unshare --fork \
				-Ur \
				--mount --uts --ipc --net --pid --mount-proc \
				--root="$ROOT_DIR_PATH" \
				"$CMD"
		;;

	--help)
		echo 'Usage: invoke-as.sh [opt] [root-dir [cmd]]'
		echo '    --help         : this help'
		echo '    --chroot       : sudo chroot         root-dir [cmd]'
		echo '    --unshare-root : sudo unshare ..     root-dir [cmd]'
		echo '    --unshare-user :      unshare -Ur .. root-dir [cmd]'
		;;

	*)
		echo "ignore unsupported: $1" >&2
		;;
esac
