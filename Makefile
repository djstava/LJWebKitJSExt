#############################################################################
#    (c)2010-2011 Broadcom Corporation
#
# This program is the proprietary software of Broadcom Corporation and/or its licensors,
# and may only be used, duplicated, modified or distributed pursuant to the terms and
# conditions of a separate, written license agreement executed between you and Broadcom
# (an "Authorized License").  Except as set forth in an Authorized License, Broadcom grants
# no license (express or implied), right to use, or waiver of any kind with respect to the
# Software, and Broadcom expressly reserves all rights in and to the Software and all
# intellectual property rights therein.  IF YOU HAVE NO AUTHORIZED LICENSE, THEN YOU
# HAVE NO RIGHT TO USE THIS SOFTWARE IN ANY WAY, AND SHOULD IMMEDIATELY
# NOTIFY BROADCOM AND DISCONTINUE ALL USE OF THE SOFTWARE.
#
# Except as expressly set forth in the Authorized License,
#
# 1.     This program, including its structure, sequence and organization, constitutes the valuable trade
# secrets of Broadcom, and you shall use all reasonable efforts to protect the confidentiality thereof,
# and to use this information only in connection with your use of Broadcom integrated circuit products.
#
# 2.     TO THE MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED "AS IS"
# AND WITH ALL FAULTS AND BROADCOM MAKES NO PROMISES, REPRESENTATIONS OR
# WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY, OR OTHERWISE, WITH RESPECT TO
# THE SOFTWARE.  BROADCOM SPECIFICALLY DISCLAIMS ANY AND ALL IMPLIED WARRANTIES
# OF TITLE, MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR A PARTICULAR PURPOSE,
# LACK OF VIRUSES, ACCURACY OR COMPLETENESS, QUIET ENJOYMENT, QUIET POSSESSION
# OR CORRESPONDENCE TO DESCRIPTION. YOU ASSUME THE ENTIRE RISK ARISING OUT OF
# USE OR PERFORMANCE OF THE SOFTWARE.
#
# 3.     TO THE MAXIMUM EXTENT PERMITTED BY LAW, IN NO EVENT SHALL BROADCOM OR ITS
# LICENSORS BE LIABLE FOR (i) CONSEQUENTIAL, INCIDENTAL, SPECIAL, INDIRECT, OR
# EXEMPLARY DAMAGES WHATSOEVER ARISING OUT OF OR IN ANY WAY RELATING TO YOUR
# USE OF OR INABILITY TO USE THE SOFTWARE EVEN IF BROADCOM HAS BEEN ADVISED OF
# THE POSSIBILITY OF SUCH DAMAGES; OR (ii) ANY AMOUNT IN EXCESS OF THE AMOUNT
# ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. $1, WHICHEVER IS GREATER. THESE
# LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF ESSENTIAL PURPOSE OF
# ANY LIMITED REMEDY.
#
# $brcm_Workfile: Makefile $
# $brcm_Revision: 18 $
# $brcm_Date: 6/9/11 9:23p $
#
# Module Description:
#
# Revision History:
#
# $brcm_Log: /AppLibs/broadcom/webbrowser/build/Makefile $
# 
# 18   6/9/11 9:23p ismailk
# SW7425-596: Change the rsynch option from "-r" to "-a"
# 
# 17   5/31/11 6:51p leventa
# SW7425-667: Added plugin enable flag to CFLAGS
# 
# 16   4/28/11 9:26p maivu
# SW7425-461: fix work-around for older toolchains
# 
# 15   4/27/11 7:48p maivu
# SW7425-461: added  -fno-ipa-sra to workaround 2.6.37-1.0 toolchain
#  failure
# 
# 14   2/1/11 4:41p leventa
# SW7422-238: Remove iconv dependency
# 
# 11   6/15/10 4:24p leventa
# SW7420-791: Change permissions of python files
# 
# 10   6/3/10 6:45p ismailk
# SW7420-791: List the cmake files in the build directory
# 
# 9   6/3/10 2:54p ismailk
# SW7420-791: Add sync after rsync.
#
# 8   4/19/10 9:41p ismailk
# SW7420-608: Copy the prebuilt/libwebkit-brcm.so* to target lib folder
#  before compiling webkit.
#
# 7   4/19/10 3:59p leventa
# SW7420-608: Changed prebuilt path
#
# 6   4/18/10 10:04p ismailk
# SW7420-608: Set "x" mode for start scripts.
#
# 5   4/14/10 3:51p ismailk
# SW7420-608: Final "start" script changes.
#
# 4   4/14/10 11:57a ismailk
# SW7420-608: Copy the start_<app> scripts instead of nexus
#
# 3   4/13/10 3:29p ismailk
# SW7420-608: Copy the "nexus" script into browsertest and bmc
#  directories.
#
#
#############################################################################

# Force prebuilt ON/OFF
WEBKIT_FORCE_PREBUILD?=OFF
# Video backend can be bmedia, card (bluray) or space (dtv)
WEBKIT_VIDEO_BACKEND?=BMEDIA
WEBKIT_VERBOSE?=n
WEBKIT_NATIVE?=n


PWD := ${shell pwd}
APPLIBS_TOP ?= $(shell cd ${PWD}/../../.. ; pwd)
OPENSOURCE ?= $(shell cd ${APPLIBS_TOP}/opensource ; pwd)
NEXUS_TOP ?= $(shell cd ${APPLIBS_TOP}/../nexus ; pwd)
WEBKIT_TOP:=$(shell cd ${PWD}/.. ; pwd)

CMAKE_HOST_VER ?= 2.8.10.2
CMAKE_BINARY_TARBALL ?= $(APPLIBS_TOP)/opensource/common/cmake-$(CMAKE_HOST_VER)-Linux-i386.tar.gz
CMAKE_BIN_PATH ?= $(APPLIBS_TOP)/opensource/common


WEBKIT_VER?=r49229
WEBKIT_NAME:=webkit-$(WEBKIT_VER)
WEBKIT_SOURCE_TARBALL:=$(WEBKIT_NAME).tar.gz

WEBKIT_SRC_PATH:=${WEBKIT_TOP}/src
WEBKIT_TAR_PATH:=${OPENSOURCE}/webkit
WEBKIT_INTERNAL_PATH:= ${WEBKIT_TOP}/internal

ifeq ($(WEBKIT_DEBUG),y)
WEBKIT_ENABLE_DEBUG:=ON
WEBKIT_CMAKE_BUILD_TYPE:=Debug
else
WEBKIT_ENABLE_DEBUG:=OFF
WEBKIT_CMAKE_BUILD_TYPE:=Release
endif


ifeq ($(WEBKIT_NATIVE),n)

WEBKIT_CONFIGURE:=.configure
ifeq ($(filter %clean,$(MAKECMDGOALS)),)
include ${OPENSOURCE}/common/common.inc
include ${OPENSOURCE}/directfb/build/directfb_common.inc
include ${OPENSOURCE}/libcurl/libcurl_ver.inc
include ${NEXUS_TOP}/../BSEAV/lib/openssl/openssl_ver.inc
-include ${OPENSOURCE}/zlib/libzlib_ver.inc
-include ${OPENSOURCE}/freetype/freetype_ver.inc
-include ${OPENSOURCE}/libpng/libpng_ver.inc
-include ${OPENSOURCE}/jpeg/libjpeg_ver.inc
include ${OPENSOURCE}/cairo/cairo_ver.inc
include ${OPENSOURCE}/fontconfig/fontconfig_ver.inc
include ${OPENSOURCE}/icu/icu_ver.inc
include ${OPENSOURCE}/libxml2/libxml2_ver.inc
include ${OPENSOURCE}/libxslt/libxslt_ver.inc
include ${OPENSOURCE}/pixman/pixman_ver.inc
include ${OPENSOURCE}/sqlite/sqlite_ver.inc
endif

ifeq ($(WEBKIT_VERBOSE),y)
	MAKE_OPTIONS:=${MAKE_OPTIONS} VERBOSE=1
endif

WEBKIT_AAL_PATH:=${WEBKIT_TOP}/aal
WEBKIT_PREBUILT_PATH:=${WEBKIT_TOP}/prebuilt
WEBKIT_APP_PATH:=${WEBKIT_TOP}/app

ifeq ($(WEBKIT_DEBUG),y)
WEBKIT_BUILD_PATH:=${WEBKIT_TOP}/tmpDebug
else
WEBKIT_BUILD_PATH:=${WEBKIT_TOP}/tmp
endif

WEBKIT_LIB_FOLDER:=${APPLIBS_TARGET_DIR}/lib
WEBKIT_INC_FOLDER:=${APPLIBS_TARGET_DIR}/include
WEBKIT_PKG_FOLDER:=${APPLIBS_TARGET_DIR}/lib/pkgconfig
WEBKIT_BIN_FOLDER:=${APPLIBS_TARGET_DIR}/bin

# Video backend makefile should be named in underscore and be placed in the build folder
LOWER_WEBKIT_VIDEO_BACKEND ?= $(shell echo $(WEBKIT_VIDEO_BACKEND) | tr A-Z a-z)
include ${WEBKIT_TOP}/build/${LOWER_WEBKIT_VIDEO_BACKEND}.inc

WEBKIT_PKG_CONFIG_PATH:=${DFB_FREETYPE_INSTALL_PKG_CONFIG_DIR}:${DIRECTFB_INSTALL_PKG_CONFIG_DIR}:${LIBFREETYPE_PKG_PATH}:${LIBZLIB_PKG_PATH}:${LIBPNG_PKG_PATH}:${SQLITE_PKG_PATH}:${LIBCURL_PKG_PATH}:${FONTCONFIG_PKG_PATH}:${CAIRO_PKG_PATH}:${ICU_PKG_PATH}:${LIBXML2_PKG_PATH}:${LIBXSLT_PKG_PATH}:${PIXMAN_PKG_PATH}


GCC_VERSION := $(shell $(CC) -dumpversion)

ifeq ($(GCC_VERSION),4.5.2)
WEBKIT_CFLAGS?= -O2 -fno-ipa-sra -fPIC ${CFLAGS} ${WEBKIT_VIDEO_BACKEND_CFLAGS} ${OPENSSL_CFLAGS} -I$(NEXUS_TOP)/modules/core/include -I$(NEXUS_TOP)/base/include/public -I$(NEXUS_TOP)/modules/pwm/include -I$(NEXUS_TOP)/modules/i2c/include -I$(NEXUS_TOP)/modules/gpio/include -I$(NEXUS_TOP)/modules/led/include -I$(NEXUS_TOP)/modules/ir_input/include -I$(NEXUS_TOP)/modules/ir_blaster/include -I$(NEXUS_TOP)/modules/input_capture/include -I$(NEXUS_TOP)/modules/keypad/include -I$(NEXUS_TOP)/modules/frontend/common/include -I$(NEXUS_TOP)/modules/frontend/3461/include/ -I$(NEXUS_TOP)/modules/spi/include -I$(NEXUS_TOP)/modules/security/include -I$(NEXUS_TOP)/extensions/security/keyladder/include/40nm -I$(NEXUS_TOP)/extensions/security/otpmsp/include/40nm -I$(NEXUS_TOP)/extensions/security/usercmd/include/40nm -I$(NEXUS_TOP)/extensions/security/regver/include/40nm -I$(NEXUS_TOP)/extensions/security/secureaccess/include -I$(NEXUS_TOP)/extensions/security/securersa/include -I$(NEXUS_TOP)/extensions/security/rawcommand/include -I$(NEXUS_TOP)/extensions/security/iplicensing/include -I$(NEXUS_TOP)/extensions/security/bseckcmd/include -I$(NEXUS_TOP)/extensions/security/msiptv/include -I$(NEXUS_TOP)/extensions/security/genrootkey/include -I$(NEXUS_TOP)/extensions/security/securepkl/include -I$(NEXUS_TOP)/modules/picture_decoder/include -I$(NEXUS_TOP)/modules/graphicsv3d/include -I$(NEXUS_TOP)/modules/dma/include -I$(NEXUS_TOP)/modules/transport/include -I$(NEXUS_TOP)/modules/video_decoder/include -I$(NEXUS_TOP)/modules/audio/include/ape_raaga -I$(NEXUS_TOP)/modules/audio/include -I$(NEXUS_TOP)/extensions/audio/dsp_video_encoder/include -I$(NEXUS_TOP)/modules/surface/include -I$(NEXUS_TOP)/modules/astm/include -I$(NEXUS_TOP)/modules/display/include -I$(NEXUS_TOP)/modules/graphics2d/include -I$(NEXUS_TOP)/modules/sync_channel/include -I$(NEXUS_TOP)/modules/hdmi_output/include -I$(NEXUS_TOP)/modules/cec/include -I$(NEXUS_TOP)/modules/smartcard/include -I$(NEXUS_TOP)/modules/surface_compositor/include -I$(NEXUS_TOP)/modules/input_router/include -I$(NEXUS_TOP)/modules/simple_decoder/include -I$(NEXUS_TOP)/modules/video_encoder/include -I$(NEXUS_TOP)/modules/stream_mux/include -I$(NEXUS_TOP)/modules/file_mux/include -I$(NEXUS_TOP)/modules/file/include -I$(NEXUS_TOP)/modules/file/include/linuxuser -I$(NEXUS_TOP)/modules/playback/include -I$(NEXUS_TOP)/modules/record/include -I$(NEXUS_TOP)/../magnum/basemodules/kni/linuxuser -I$(NEXUS_TOP)/../magnum/basemodules/std -I$(NEXUS_TOP)/../magnum/basemodules/std/config -I$(NEXUS_TOP)/../magnum/basemodules/std/types/linuxuser -I$(NEXUS_TOP)/../magnum/basemodules/dbg -I$(NEXUS_TOP)/../magnum/basemodules/chp/include/common -I$(NEXUS_TOP)/../magnum/basemodules/chp/include/7231/common -I$(NEXUS_TOP)/../magnum/basemodules/chp/include/7231/rdb/b0 -I$(NEXUS_TOP)/../magnum/basemodules/chp/src/common -I$(NEXUS_TOP)/../magnum/basemodules/chp/include/7231/common/pwr/b0 -I$(NEXUS_TOP)/../magnum/basemodules/chp/src/7231/pwr/b0 -I$(NEXUS_TOP)/../magnum/basemodules/reg -I$(NEXUS_TOP)/../magnum/basemodules/err -I$(NEXUS_TOP)/../magnum/commonutils/lst -I$(NEXUS_TOP)/../magnum/commonutils/img -I$(NEXUS_TOP)/../magnum/../BSEAV/lib/bfile -I$(APPLIBS_TOP)/opensource/directfb/src/DirectFB-Broadcom -I$(APPLIBS_TOP)/opensource/directfb/src/DirectFB-Broadcom/platform -I${APPLIBS_TOP}/../rockford/middleware/opengles -I${APPLIBS_TOP}/../rockford/middleware/opengles/GLES -DPLUGIN_FULLSCREEN_SUPPORT ${JPEG_CFLAGS}
WEBKIT_INC_CFLAGS:= -D_REENTRANT -I${WEBKIT_INC_FOLDER}/webkit -Wall -W -Wcast-align -Wchar-subscripts -Wreturn-type -Wformat -Wformat-security -Wno-format-y2k -Wundef -Wmissing-format-attribute -Wpointer-arith -Wwrite-strings -Wno-unused-parameter -Wno-parentheses -fvisibility-inlines-hidden -fPIC -fno-exceptions -fvisibility=hidden -O2 -fno-ipa-sra -fPIC -DPLUGIN_FULLSCREEN_SUPPORT
else
WEBKIT_CFLAGS?= -O2 -fPIC ${CFLAGS} ${WEBKIT_VIDEO_BACKEND_CFLAGS} ${OPENSSL_CFLAGS} -I$(NEXUS_TOP)/modules/core/include -I$(NEXUS_TOP)/base/include/public -I$(NEXUS_TOP)/modules/pwm/include -I$(NEXUS_TOP)/modules/i2c/include -I$(NEXUS_TOP)/modules/gpio/include -I$(NEXUS_TOP)/modules/led/include -I$(NEXUS_TOP)/modules/ir_input/include -I$(NEXUS_TOP)/modules/ir_blaster/include -I$(NEXUS_TOP)/modules/input_capture/include -I$(NEXUS_TOP)/modules/keypad/include -I$(NEXUS_TOP)/modules/frontend/common/include -I$(NEXUS_TOP)/modules/frontend/3461/include/ -I$(NEXUS_TOP)/modules/spi/include -I$(NEXUS_TOP)/modules/security/include -I$(NEXUS_TOP)/extensions/security/keyladder/include/40nm -I$(NEXUS_TOP)/extensions/security/otpmsp/include/40nm -I$(NEXUS_TOP)/extensions/security/usercmd/include/40nm -I$(NEXUS_TOP)/extensions/security/regver/include/40nm -I$(NEXUS_TOP)/extensions/security/secureaccess/include -I$(NEXUS_TOP)/extensions/security/securersa/include -I$(NEXUS_TOP)/extensions/security/rawcommand/include -I$(NEXUS_TOP)/extensions/security/iplicensing/include -I$(NEXUS_TOP)/extensions/security/bseckcmd/include -I$(NEXUS_TOP)/extensions/security/msiptv/include -I$(NEXUS_TOP)/extensions/security/genrootkey/include -I$(NEXUS_TOP)/extensions/security/securepkl/include -I$(NEXUS_TOP)/modules/picture_decoder/include -I$(NEXUS_TOP)/modules/graphicsv3d/include -I$(NEXUS_TOP)/modules/dma/include -I$(NEXUS_TOP)/modules/transport/include -I$(NEXUS_TOP)/modules/video_decoder/include -I$(NEXUS_TOP)/modules/audio/include/ape_raaga -I$(NEXUS_TOP)/modules/audio/include -I$(NEXUS_TOP)/extensions/audio/dsp_video_encoder/include -I$(NEXUS_TOP)/modules/surface/include -I$(NEXUS_TOP)/modules/astm/include -I$(NEXUS_TOP)/modules/display/include -I$(NEXUS_TOP)/modules/graphics2d/include -I$(NEXUS_TOP)/modules/sync_channel/include -I$(NEXUS_TOP)/modules/hdmi_output/include -I$(NEXUS_TOP)/modules/cec/include -I$(NEXUS_TOP)/modules/smartcard/include -I$(NEXUS_TOP)/modules/surface_compositor/include -I$(NEXUS_TOP)/modules/input_router/include -I$(NEXUS_TOP)/modules/simple_decoder/include -I$(NEXUS_TOP)/modules/video_encoder/include -I$(NEXUS_TOP)/modules/stream_mux/include -I$(NEXUS_TOP)/modules/file_mux/include -I$(NEXUS_TOP)/modules/file/include -I$(NEXUS_TOP)/modules/file/include/linuxuser -I$(NEXUS_TOP)/modules/playback/include -I$(NEXUS_TOP)/modules/record/include -I$(NEXUS_TOP)/../magnum/basemodules/kni/linuxuser -I$(NEXUS_TOP)/../magnum/basemodules/std -I$(NEXUS_TOP)/../magnum/basemodules/std/config -I$(NEXUS_TOP)/../magnum/basemodules/std/types/linuxuser -I$(NEXUS_TOP)/../magnum/basemodules/dbg -I$(NEXUS_TOP)/../magnum/basemodules/chp/include/common -I$(NEXUS_TOP)/../magnum/basemodules/chp/include/7231/common -I$(NEXUS_TOP)/../magnum/basemodules/chp/include/7231/rdb/b0 -I$(NEXUS_TOP)/../magnum/basemodules/chp/src/common -I$(NEXUS_TOP)/../magnum/basemodules/chp/include/7231/common/pwr/b0 -I$(NEXUS_TOP)/../magnum/basemodules/chp/src/7231/pwr/b0 -I$(NEXUS_TOP)/../magnum/basemodules/reg -I$(NEXUS_TOP)/../magnum/basemodules/err -I$(NEXUS_TOP)/../magnum/commonutils/lst -I$(NEXUS_TOP)/../magnum/commonutils/img -I$(NEXUS_TOP)/../magnum/../BSEAV/lib/bfile -I$(APPLIBS_TOP)/opensource/directfb/src/DirectFB-Broadcom -I$(APPLIBS_TOP)/opensource/directfb/src/DirectFB-Broadcom/platform -I${APPLIBS_TOP}/../rockford/middleware/opengles -I${APPLIBS_TOP}/../rockford/middleware/opengles/GLES -DPLUGIN_FULLSCREEN_SUPPORT ${JPEG_CFLAGS}
WEBKIT_INC_CFLAGS:= -D_REENTRANT -I${WEBKIT_INC_FOLDER}/webkit -Wall -W -Wcast-align -Wchar-subscripts -Wreturn-type -Wformat -Wformat-security -Wno-format-y2k -Wundef -Wmissing-format-attribute -Wpointer-arith -Wwrite-strings -Wno-unused-parameter -Wno-parentheses -fvisibility-inlines-hidden -fPIC -fno-exceptions -fvisibility=hidden -O2 -fPIC -DPLUGIN_FULLSCREEN_SUPPORT
endif

WEBKIT_LDFLAGS?=${LDFLAGS} ${WEBKIT_VIDEO_BACKEND_LDFLAGS} -L${DIRECTFB_OBJECT_DIR}/lib -L$(DIRECTFB_INSTALL_LIB_DIR) -L${APPLIBS_TARGET_LIB_DIR} -lssl -lcrypto -L${WEBKIT_LIB_FOLDER}
WEBKIT_INC_LDFLAGS:= -L${WEBKIT_LIB_FOLDER} -lwebkit -lwebkit-brcm -lwebkit-video-brcm
WEBKIT_CONFIGURE:=.configure

WEBKIT_TARGET:=.configure .$(WEBKIT_NAME) install
else
WEBKIT_PKG_CONFIG_PATH?=/usr/local/lib/pkgconfig:/usr/lib/pkgconfig
WEBKIT_CFLAGS?=-DX11_TEST

ifeq ($(WEBKIT_DEBUG),y)
WEBKIT_BUILD_PATH:=${WEBKIT_TOP}/tmpNativeDebug
else
WEBKIT_BUILD_PATH:=${WEBKIT_TOP}/tmpNative
endif

WEBKIT_CONFIGURE:=.configureNative
WEBKIT_TARGET:=native
BRCM_WEBKIT_NATIVE:=ON
endif

.PHONY: clean distclean .setup .sync .configure .incfile .webkit .video video webkit all install target-clean test

all: $(WEBKIT_TARGET)

.setup:
	@echo ${WEBKIT_BUILD_PATH}
	@if [ ! -d "${CMAKE_BIN_PATH}/cmake-$(CMAKE_HOST_VER)-Linux-i386" ]; then \
		echo "${CMAKE_BIN_PATH} not found"; \
		if [ -e "${CMAKE_BINARY_TARBALL}" ]; then \
			echo "================ Extracting CMake tarball"; \
			mkdir -p ${CMAKE_BIN_PATH}; \
			tar -xzf ${CMAKE_BINARY_TARBALL} -C ${CMAKE_BIN_PATH}; \
		else \
			echo "CMake tarball not found"; exit 1;\
		fi \
	fi


	@if [ ! -d "${WEBKIT_BUILD_PATH}" ]; then \
		echo "${WEBKIT_BUILD_PATH} not found"; \
		if [ -e "${WEBKIT_TAR_PATH}/${WEBKIT_SOURCE_TARBALL}" ]; then \
			mkdir -p ${WEBKIT_BUILD_PATH}; \
			if [ ! -d "${WEBKIT_TAR_PATH}/${WEBKIT_NAME}" ]; then \
				echo "================ Extracting WEBKIT tarball"; \
				tar -xzf ${WEBKIT_TAR_PATH}/${WEBKIT_SOURCE_TARBALL} -C ${WEBKIT_TAR_PATH}; \
			fi \
		else \
			echo "Webkit Source is not complete"; exit 1; \
		fi \
	fi

.sync: .setup
	@echo "================ Sync Webkit source"
	@rsync -a ${WEBKIT_TAR_PATH}/${WEBKIT_NAME}/* ${WEBKIT_BUILD_PATH}
	@rsync -a ${WEBKIT_TAR_PATH}/broadcom_files/${WEBKIT_VER}/* ${WEBKIT_BUILD_PATH}
	@rsync -a ${WEBKIT_SRC_PATH}/* ${WEBKIT_BUILD_PATH}
	@if [ -d "${WEBKIT_INTERNAL_PATH}" ]; then \
		echo "================ Sync Webkit BRCM source"; \
		rsync -a ${WEBKIT_INTERNAL_PATH}/* ${WEBKIT_BUILD_PATH}; \
	fi
	@find ${WEBKIT_BUILD_PATH} -name "*.py" | xargs chmod +x


.configure: .sync
	@if [ ! -e "${WEBKIT_BUILD_PATH}/Makefile" ]; then \
		echo "================ Configure Webkit"; \
		cd ${WEBKIT_BUILD_PATH}; \
		rm -rf CMakeCache.txt ; \
		rm -rf generated* ; \
		CFLAGS="${WEBKIT_CFLAGS}" \
		CXXFLAGS="${WEBKIT_CFLAGS}" \
		LDFLAGS="${WEBKIT_LDFLAGS}" \
		PKG_CONFIG_PATH="${WEBKIT_PKG_CONFIG_PATH}" \
		${CMAKE_BIN_PATH}/cmake-$(CMAKE_HOST_VER)-Linux-i386/bin/cmake \
		-D BRCM_WEBKIT_BUILD_DEBUG:STRING="${WEBKIT_ENABLE_DEBUG}" \
		-D BRCM_WEBKIT_TOP:STRING="${WEBKIT_TOP}" \
		-D BRCM_WEBKIT_PREBUILT_PATH:STRING="${WEBKIT_PREBUILT_PATH}" \
		-D BRCM_WEBKIT_AAL_PATH:STRING="${WEBKIT_AAL_PATH}" \
		-D BRCM_PLATFORM:STRING="${PLATFORM}" \
		-D BRCM_BCHP_VER:STRING="${LOWER_BCHP_VER}" \
		-D BRCM_VIDEO_BACKEND:STRING="${WEBKIT_VIDEO_BACKEND}" \
		-D BRCM_FORCE_PREBUILD:BOOL="${WEBKIT_FORCE_PREBUILD}" \
		-D CMAKE_FIND_ROOT_PATH:STRING="${APPLIBS_TARGET_DIR}" \
		-D CMAKE_BUILD_TYPE:STRING="${WEBKIT_CMAKE_BUILD_TYPE}" \
		-D CMAKE_INSTALL_PREFIX:STRING=${APPLIBS_TARGET_DIR} \
		-D CMAKE_C_COMPILER:FILEPATH=${CC} \
		-D CMAKE_CXX_COMPILER:FILEPATH=${CXX} \
		-D CMAKE_C_FLAGS_RELEASE:STRING="${WEBKIT_CFLAGS}" \
		-D CMAKE_CXX_FLAGS_RELEASE:STRING="${WEBKIT_CFLAGS}" \
		-D CMAKE_C_FLAGS_DEBUG:STRING="${WEBKIT_CFLAGS}" \
		-D CMAKE_CXX_FLAGS_DEBUG:STRING="${WEBKIT_CFLAGS} -g" \
		-D CMAKE_LINKER:FILEPATH=${LD} \
		-D CMAKE_EXE_LINKER_FLAGS:STRING="${WEBKIT_LDFLAGS} ${WEBKIT_EXE_VIDEO_BACKEND_LDFLAGS}" \
		-D CMAKE_MODULE_LINKER_FLAGS:STRING="${WEBKIT_LDFLAGS}" \
		-D CMAKE_SHARED_LINKER_FLAGS:STRING="${WEBKIT_LDFLAGS}" \
		-D ENABLE_3D_RENDERING:BOOL=ON \
		-D ENABLE_CEHTML:BOOL=ON \
		-D ENABLE_CEHTML_VIDEO:BOOL=ON \
		-D ENABLE_GEOLOCATION:BOOL=ON \
		-D ENABLE_DATABASE:BOOL=ON \
		-D ENABLE_GEOLOCATION:BOOL=OFF \
		-D ENABLE_DOM_STORAGE:BOOL=ON \
		-D ENABLE_NPAPI:BOOL=ON \
		-D ENABLE_DEBUG:BOOL="${WEBKIT_ENABLE_DEBUG}" \
		-D ENABLE_DAE:BOOL=OFF \
		-D ENABLE_DAE_METADATA:BOOL=OFF \
		-D ENABLE_DAE_PERMISSION:BOOL=OFF \
		-D ENABLE_DAE_PVR:BOOL=OFF \
		-D ENABLE_DAE_VIDEO:BOOL=OFF \
		-D ENABLE_JIT_JSC:BOOL=ON \
		-D ENABLE_OFFLINE_DYNAMIC_ENTRIES:BOOL=OFF \
		-D ENABLE_SHARED_WORKERS:BOOL=ON \
		-D ENABLE_WORKERS:BOOL=ON \
		-D ENABLE_YARR:BOOL=ON \
		-D ENABLE_MULTIPLE_THREADS:BOOL=ON \
		-D ENABLE_NOTIFICATIONS:BOOL=ON \
		-D ENABLE_WEB_SOCKETS:BOOL=ON \
		-D ENABLE_FAST_MALLOC:BOOL=ON \
		-D ENABLE_HBBTV_0_8:BOOL=OFF \
        -D ENABLE_ACCELERATED_COMPOSITING:BOOL=ON \
		-D USE_METADATA:STRING=NONE \
		-D ICU_CONFIG_EXECUTABLE:STRING=${ICU_CONFIG_PATH}/icu-config \
		-D USE_AIT:STRING=NONE \
		-D USE_FONTS:STRING=CAIRO \
		-D USE_GRAPHICS:STRING=MANGAREVA \
		-D USE_I18N:STRING=ICU \
		-D USE_VIDEO:STRING=${BRCM_VIDEO_BACKEND} \
		-D WITH_OWB_CONFIG_DIR:STRING=/root \
		-D USE_PVR:STRING=NONE ./; \
	fi

.configureNative: .sync
	@if [ ! -e "${WEBKIT_BUILD_PATH}/Makefile" ]; then \
		echo "================ Configure Webkit"; \
		cd ${WEBKIT_BUILD_PATH}; \
		rm -rf CMakeCache.txt ; \
		rm -rf generated* ; \
		CFLAGS="${WEBKIT_CFLAGS}" \
		CXXFLAGS="${WEBKIT_CFLAGS}" \
		LDFLAGS="${WEBKIT_LDFLAGS}" \
		PKG_CONFIG_PATH="${WEBKIT_PKG_CONFIG_PATH}" \
		${CMAKE_BIN_PATH}/cmake-$(CMAKE_HOST_VER)-Linux-i386/bin/cmake \
		-D BRCM_WEBKIT_TOP:STRING="${WEBKIT_TOP}" \
		-D BRCM_WEBKIT_PREBUILT_PATH:STRING="${WEBKIT_PREBUILT_PATH}" \
		-D BRCM_WEBKIT_AAL_PATH:STRING="${WEBKIT_AAL_PATH}" \
		-D BRCM_PLATFORM:STRING="${PLATFORM}" \
		-D BRCM_BCHP_VER:STRING="${LOWER_BCHP_VER}" \
		-D BRCM_VIDEO_BACKEND:STRING="${WEBKIT_VIDEO_BACKEND}" \
		-D BRCM_FORCE_PREBUILD:BOOL="${WEBKIT_FORCE_PREBUILD}" \
		-D BRCM_WEBKIT_NATIVE:BOOL="${BRCM_WEBKIT_NATIVE}" \
		-D CMAKE_FIND_ROOT_PATH:STRING="${APPLIBS_TARGET_DIR}" \
		-D CMAKE_BUILD_TYPE:STRING=Debug \
		-D CMAKE_INSTALL_PREFIX:STRING=${APPLIBS_TARGET_DIR} \
		-D CMAKE_C_COMPILER:FILEPATH=gcc \
		-D CMAKE_CXX_COMPILER:FILEPATH=g++ \
		-D CMAKE_CXX_FLAGS_RELEASE:STRING="${WEBKIT_CFLAGS}" \
		-D CMAKE_C_FLAGS_RELEASE:STRING="${WEBKIT_CFLAGS}" \
		-D CMAKE_LINKER:FILEPATH=g++ \
		-D CMAKE_EXE_LINKER_FLAGS:STRING="${WEBKIT_LDFLAGS} ${WEBKIT_EXE_VIDEO_BACKEND_LDFLAGS}" \
		-D CMAKE_MODULE_LINKER_FLAGS:STRING="${WEBKIT_LDFLAGS}" \
		-D CMAKE_SHARED_LINKER_FLAGS:STRING="${WEBKIT_LDFLAGS}" \
		-D ENABLE_3D_RENDERING:BOOL=ON \
		-D ENABLE_CEHTML:BOOL=ON \
		-D ENABLE_CEHTML_VIDEO:BOOL=OFF \
		-D ENABLE_GEOLOCATION:BOOL=ON \
		-D ENABLE_DATABASE:BOOL=ON \
		-D ENABLE_GEOLOCATION:BOOL=OFF \
		-D ENABLE_DOM_STORAGE:BOOL=ON \
		-D ENABLE_NPAPI:BOOL=ON \
		-D ENABLE_DEBUG:BOOL=ON \
		-D ENABLE_DAE:BOOL=OFF \
		-D ENABLE_DAE_METADATA:BOOL=OFF \
		-D ENABLE_DAE_PERMISSION:BOOL=OFF \
		-D ENABLE_DAE_PVR:BOOL=OFF \
		-D ENABLE_DAE_VIDEO:BOOL=OFF \
		-D ENABLE_JIT_JSC:BOOL=OFF \
		-D ENABLE_OFFLINE_DYNAMIC_ENTRIES:BOOL=OFF \
		-D ENABLE_SHARED_WORKERS:BOOL=ON \
		-D ENABLE_WORKERS:BOOL=ON \
		-D ENABLE_YARR:BOOL=ON \
		-D ENABLE_MULTIPLE_THREADS:BOOL=ON \
		-D ENABLE_FAST_MALLOC:BOOL=ON \
		-D ENABLE_HBBTV_0_8:BOOL=OFF \
		-D ENABLE_ACCELERATED_COMPOSITING:BOOL=ON \
		-D ENABLE_VIDEO:BOOL=OFF \
		-D ENABLE_TESTS:BOOL=OFF \
		-D USE_METADATA:STRING=NONE \
		-D ICU_CONFIG_EXECUTABLE:STRING=/usr/bin/icu-config \
		-D USE_AIT:STRING=NONE \
		-D USE_FONTS:STRING=CAIRO \
		-D USE_GRAPHICS:STRING=MANGAREVA \
		-D USE_I18N:STRING=ICU \
		-D USE_VIDEO:STRING=${BRCM_VIDEO_BACKEND} \
		-D WITH_OWB_CONFIG_DIR:STRING=/root \
		-D USE_PVR:STRING=NONE ./; \
	fi



.$(WEBKIT_NAME): .incfile
	@if [ ! -e "${WEBKIT_BUILD_PATH}/Makefile" ]; then \
		echo "${WEBKIT_NAME} is not configured!"; exit 1;\
	fi

	@echo "================ Compiling WEBKIT"
	@if [ ! -d "${WEBKIT_INTERNAL_PATH}" ]; then \
		echo "Copying prebuilt binaries to target lib directory"; \
		cp -af ${WEBKIT_PREBUILT_PATH}/* ${APPLIBS_TARGET_LIB_DIR}; \
	fi
	${MAKE} ${MAKE_OPTIONS} -C ${WEBKIT_BUILD_PATH} all ${MAKE_SUFFIX}
	@echo "================ WEBKIT Compiled!"

.incfile:
	@rm -rf webbrowser_ver.inc
	@echo "WEBKIT_VER:="$(WEBKIT_VER) >> webbrowser_ver.inc
	@echo "WEBKIT_NAME:="$(WEBKIT_NAME) >> webbrowser_ver.inc
	@echo "WEBKIT_CFLAGS:="$(WEBKIT_INC_CFLAGS) >> webbrowser_ver.inc
	@echo "WEBKIT_LDFLAGS:="$(WEBKIT_INC_LDFLAGS) >> webbrowser_ver.inc
	@echo "WEBKIT_CONFIG_PATH:="$(WEBKIT_BIN_FOLDER) >> webbrowser_ver.inc
	@echo "WEBKIT_PKG_PATH:="$(WEBKIT_PKG_FOLDER) >> webbrowser_ver.inc
	@echo "WEBKIT_$$(sed -n '/CXX_DEFINES/p'  ../tmp/WebCore/CMakeFiles/webcore.dir/flags.make)" >> webbrowser_ver.inc

.video:
	@echo "================ Compiling WEBKIT Video Backend"
	${MAKE} ${MAKE_OPTIONS} -C ${WEBKIT_BUILD_PATH} webkit-video-brcm/fast ${MAKE_SUFFIX}

.webkit: $(WEBKIT_CONFIGURE) .incfile
	@echo "================ Compiling WEBKIT library"
	${MAKE} ${MAKE_OPTIONS} -C ${WEBKIT_BUILD_PATH} webkit ${MAKE_SUFFIX}


.browsertest:
	@echo "================ Compiling WEBKIT"
	@echo "options: ${MAKE_OPTIONS}"
	${MAKE} ${MAKE_OPTIONS} -C ${WEBKIT_APP_PATH} all ${MAKE_SUFFIX}
	@echo "================ WEBKIT Compiled!"

webkit: $(WEBKIT_CONFIGURE) .incfile .webkit

video: .video

native: .configureNative .browsertest

install:
	@echo "================ Installing WEBKIT"
	@mkdir -p ${APPLIBS_TARGET_LIB_DIR}
	@mkdir -p ${APPLIBS_TARGET_LIB_DIR}
	@mkdir -p ${APPLIBS_TARGET_BIN_DIR}/browsertest
	${MAKE} -C ${WEBKIT_BUILD_PATH} install/fast ${MAKE_SUFFIX}
	@cp -af $(WEBKIT_BUILD_PATH)/lib/*.so* ${APPLIBS_TARGET_LIB_DIR}
	@if [ -d "${WEBKIT_INTERNAL_PATH}" ]; then \
		mkdir -p ${WEBKIT_PREBUILT_PATH}; \
		cp -af $(WEBKIT_BUILD_PATH)/lib/libwebkit-brcm.* ${WEBKIT_PREBUILT_PATH}; \
	fi
	@cp -af $(WEBKIT_TOP)/build/start ${APPLIBS_TARGET_BIN_DIR}/browsertest
	@cp -af $(WEBKIT_TOP)/src/fonts.conf ${APPLIBS_TARGET_BIN_DIR}/browsertest

webkitFast:
	${MAKE} ${MAKE_OPTIONS} -C ${WEBKIT_BUILD_PATH} wtf/fast ${MAKE_SUFFIX}
	${MAKE} ${MAKE_OPTIONS} -C ${WEBKIT_BUILD_PATH} jsc/fast ${MAKE_SUFFIX}
	${MAKE} ${MAKE_OPTIONS} -C ${WEBKIT_BUILD_PATH} webcore/fast ${MAKE_SUFFIX}
	${MAKE} ${MAKE_OPTIONS} -C ${WEBKIT_BUILD_PATH} webkit/fast ${MAKE_SUFFIX}
	${MAKE} ${MAKE_OPTIONS} -C ${WEBKIT_BUILD_PATH} webkit-brcm/fast ${MAKE_SUFFIX}
	${MAKE} ${MAKE_OPTIONS} -C ${WEBKIT_BUILD_PATH} webkit-video-brcm/fast ${MAKE_SUFFIX}

browsertest:
	@echo "================ Compiling BROWSERTEST"
	@echo "options: ${MAKE_OPTIONS}"
	${MAKE} ${MAKE_OPTIONS} -C ${WEBKIT_APP_PATH} all ${MAKE_SUFFIX}
	@echo "================ BROWSERTEST Compiled!"

browsertest-install: browsertest
	@echo "================ Installing BROWSERTEST"
	@mkdir -p ${APPLIBS_TARGET_BIN_DIR}/browsertest
	@cp -af $(WEBKIT_APP_PATH)/bin/browsertest ${APPLIBS_TARGET_BIN_DIR}/browsertest
	@cp -af $(WEBKIT_SRC_PATH)/fonts.conf ${APPLIBS_TARGET_BIN_DIR}/browsertest
	@cp -f $(WEBKIT_SRC_PATH)/start ${APPLIBS_TARGET_BIN_DIR}/browsertest
	@chmod 777 ${APPLIBS_TARGET_BIN_DIR}/browsertest/start
	@echo "================ BROWSERTEST Installed!"


target-clean:
	@echo "================ Removing target WEBKIT binaries"
	@rm -rf ${APPLIBS_TARGET_LIB_DIR}/libwebkit*
	@rm -rf ${APPLIBS_TARGET_INC_DIR}/webkit
	@rm -rf ${APPLIBS_TARGET_BIN_DIR}/browsertest



clean:
	@echo "================ MAKE CLEAN"
	@if [ -d ${WEBKIT_TOP}/app/trellis ]; then \
		${MAKE} -C ${WEBKIT_TOP}/app/trellis clean;\
	fi
	@if [ -d ${WEBKIT_BUILD_PATH} ]; then \
		${MAKE} -C ${WEBKIT_BUILD_PATH} clean;\
	fi
	@rm -rf ${WEBKIT_BUILD_PATH}/CMakeCache.txt
	@rm -rf ${WEBKIT_BUILD_PATH}/CMakeFiles
	@rm -rf ${WEBKIT_BUILD_PATH}/Makefile
	@rm -rf ${WEBKIT_BUILD_PATH}/lib
	@rm -rf ${WEBKIT_BUILD_PATH}/bin
	@rm -rf ${WEBKIT_APP_PATH}/obj
	@rm -rf ${WEBKIT_APP_PATH}/bin
	@echo "================ Done"

distclean:
	@echo "================ MAKE DIST CLEAN"
	@if [ -d ${WEBKIT_TOP}/app/trellis ]; then \
		${MAKE} -C ${WEBKIT_TOP}/app/trellis clean;\
	fi
	@rm -rf webbrowser_ver.inc
	@rm -rf ${WEBKIT_BUILD_PATH}
	@rm -rf ${WEBKIT_TAR_PATH}/${WEBKIT_NAME}
	@rm -rf ${WEBKIT_APP_PATH}/obj
	@rm -rf ${WEBKIT_APP_PATH}/bin
	@rm -rf ${CMAKE_BIN_PATH}/cmake-$(CMAKE_HOST_VER)-Linux-i386
	@echo "================ Done"
