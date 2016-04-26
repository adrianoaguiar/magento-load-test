#!/usr/bin/env bash

if [ $# -lt 4 ]; then
    echo "Usage: ./media.sh version magento_root_path media_set_file media_path"
    echo ""
    echo "Examples:"
    echo "  ./media.sh m1 /var/www/html media.set /path/to/media";
    echo "  ./media.sh m2 /var/www/html media.set /path/to/media";
    exit 1;
fi

MAGE_VER=$1
MAGE_PATH=$2
IMG_INPUT=$3
IMG_SOURCE=$4

check_args () {
    if [ "${MAGE_VER}" != "m1" ] && [ "${MAGE_VER}" != "m2" ]; then
        echo "ERROR: Entered incorrect Magento version";
        exit 1;
    fi

    if [ ! -d ${MAGE_PATH} ]; then
        echo "ERROR: Entered Magento root directory is not exists";
        exit 1;
    fi

    if [ ! -f ${IMG_INPUT} ]; then
        echo "ERROR: Entered media set file is not exists";
        exit 1;
    fi

    if [ ! -d ${IMG_SOURCE} ]; then
        echo "ERROR: Entered media directory is not exists";
        exit 1;
    fi

    IMG_SOURCE=$(readlink -e ${IMG_SOURCE})
}

process () {
    while IFS= read -r IMG_FILE
    do
        if [ "${MAGE_VER}" == "m1" ]; then
            MEDIA_PATH="${MAGE_PATH}/media"
        else
            MEDIA_PATH="${MAGE_PATH}/pub/media"
        fi
        IMG_PATH="${MEDIA_PATH}/catalog/product${IMG_FILE:0:4}"
        if [ ! -d "${IMG_PATH}" ]; then
            mkdir -p ${IMG_PATH}
        fi

        RND=$(printf '%02d' $(((RANDOM % 24) + 1)));

        ln -fs "${IMG_SOURCE}/0${RND}.jpg" "${MEDIA_PATH}/catalog/product${IMG_FILE}"
    done < "${IMG_INPUT}"
}

check_args;
process;
