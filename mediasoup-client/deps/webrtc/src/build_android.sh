#!/bin/bash

export PATH=/home/software/depot_tools:$PATH

. build/android/envsetup.sh

defaultout=out

args=$*

for option in $args
do
    case $option in
    	"-c"|"clean"|"c")
				echo "clean begin"
        echo $defaultout
				rm -rf $defaultout/*
				echo "clean end"
        ;;
			"32"|"arm32")
				target_cpu=arm32
				outpath=$defaultout"/"$target_cpu
				echo outpath=$outpath
				gn gen $outpath --args='use_custom_libcxx=false target_os="android" target_cpu="arm"'
        ninja -C $outpath
				;;
    	"32"|"arm32")
				target_cpu=arm64
				outpath=$defaultout"/"$target_cpu
				echo outpath=$outpath
				gn gen $outpath --args='target_os="android" target_cpu="arm64" is_debug=false is_component_build=false is_clang=true rtc_include_tests=false rtc_use_h264=true rtc_enable_protobuf=false use_rtti=true use_custom_libcxx=false'
        ninja -C $outpath
        ;;
    esac
done
