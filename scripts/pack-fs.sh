#!/bin/bash
set -e
ROOT_DIR_PATH="$2"
IMAGE_FILE_NAME="$3"

# #########################
# MAIN logic
case $1 in
	--initrd)
		echo '[BUILD INITRD]'
		if [ -z "$IMAGE_FILE_NAME" ]; then
			IMAGE_FILE_NAME="$ROOT_DIR_PATH/../initrd.gz"
		fi
		find $ROOT_DIR_PATH | cpio -o -H newc -V | gzip -9 > $IMAGE_FILE_NAME
		;;

	--squashfs)
		echo '[BUILD SQUASH IMAGE]'
		if [ -z "$IMAGE_FILE_NAME" ]; then
			IMAGE_FILE_NAME="$ROOT_DIR_PATH/../image.sqsh"
		fi
		mksquashfs  $ROOT_DIR_PATH $IMAGE_FILE_NAME
		;;

	--help)
		echo 'Usage: pack-fs.sh [targetImage] [root-dir [image-file-name]]'
		echo '    --help         : this help'
		echo '    --initrd       : initrd image, default: root-dir/../initrd.gz'
		echo '    --squashfs     : squash image, default: root-dir/../image.sqsh'
		;;

	*)
		echo "ignore unsupported: $1" >&2
		;;
esac
