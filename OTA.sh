script_path="`dirname \"$0\"`"
device="laurel_sprout"
zip=`find $script_path/out/target/product/$device/ -name Pixel*.zip | sort | head -n1 | cut -d "/" -f6`
zip_name=$script_path/out/target/product/$device/$zip
buildprop=$script_path/out/target/product/$device/system/build.prop

if [ -f $script_path/$device.json ]; then
  rm $script_path/$device.json
fi

vers=`grep -n "org.pixelexperience.version=" $buildprop | cut -d '=' -f2`
var=`grep -n "org.pixelexperience.build_date_utc" $buildprop | cut -d':' -f1`
datetime=`sed -n $var'p' < $buildprop | cut -d'=' -f2`
md5=`md5sum $zip_name | cut -d ' ' -f1`
size=`stat -c "%s" "$zip_name"`

echo '{
    "error": false,
    "version": "'$vers'",
    "filename": "'$zip'",
    "datetime": '$datetime',
    "size": '$size',
    "url": "https://downloads.royalturd.workers.dev/0:/'$zip'",
    "filehash": "'$md5'",
    "id": "'$md5'",
    "maintainers": [
        {
            "main_maintainer": false,
            "github_username": "https://github.com/royalturd",
            "name": "Rudra"
        }
    ],
    "donate_url": "",
    "website_url": "",
    "news_url": "",
    "forum_url": ""
}' >> $device.json
