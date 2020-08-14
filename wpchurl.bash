# This file is part of wpchurl, distributed under the ISC license.
# For full terms see the included COPYING file.

### Usage:
###   wpchurl [-d DIRECTORY]
###   wpchurl [-d DIRECTORY] [-HS] URL
### Options:
###   -H  Do not change the WordPress Address ("home").
###   -S  Do not change the Site Address ("siteurl").
###   -d  Directory containing the WordPress files.
### 
### If no DIRECTORY is specified, the current one will be used.
### If no URL is specified, just the active settings will be displayed.

set -euo pipefail

declare -A wpoptions=([home]=true [siteurl]=true)
directory="."
url=""
showusage=false
if args=$(getopt HSd:h $*); then
	set -- $args

	# process optional arguments
	while [[ $# -ne 0 ]]; do
		case "$1" in
			-H)
				wpoptions[home]=false; shift;;
			-S)
				wpoptions[siteurl]=false; shift;;
			-d)
				directory="$2"; shift; shift;;
			-h)
				showusage=true; shift;;
			--)
				shift; break;;
		esac
	done

	# process positional arguments
	if [[ $# -eq 1 ]]; then
		url="$1"
	elif [[ $# -gt 1 ]]; then
		showusage=true
	fi
else
	showusage=true
fi
if [[ $showusage == true ]]; then
	sed -n 's/^### //;T;p' "$0" >&2
	exit 2
fi
if [[ ! -f "$directory/wp-config.php" ]]; then
	echo "Error: Directory does not seem to contain WordPress files: $directory" >&2
	exit 1
fi

# transform PHP variables into Shell variables; sed removes possibly
# added BOM
eval "$(
php <<END | sed $'1s/^\uFEFF//'
<?php
include "$directory/wp-config.php";
echo 'db_host=', constant('DB_HOST'), ';',
     'db_name=', constant('DB_NAME'), ';',
     'db_password=', constant('DB_PASSWORD'), ';',
     'db_user=', constant('DB_USER'), ';',
     'table_prefix=', \$table_prefix;
END
)"

# put the database password in a temporary file so that it does not
# have to be passed on the command line and to avoid an input prompt
mycnfpath="$(mktemp -t)"
trap 'rm --force "$mycnfpath"' EXIT
echo -en "[client]\\npassword=$db_password\\n" >"$mycnfpath"

# change settings
if [[ -n "$url" ]]; then
	for optionname in "${!wpoptions[@]}"; do
		if [[ ${wpoptions[$optionname]} == true ]]; then
			mysql \
			  --defaults-file="$mycnfpath" \
			  --host=$db_host \
			  --database=$db_name \
			  --user=$db_user \
			  --execute="UPDATE ${table_prefix}options SET option_value=\"$url\" WHERE option_name=\"$optionname\""
		fi
	done
fi

# display settings
for optionname in "${!wpoptions[@]}"; do
	mysql \
	  --defaults-file="$mycnfpath" \
	  --host=$db_host \
	  --database=$db_name \
	  --user=$db_user \
	  --execute="SELECT option_name, option_value FROM ${table_prefix}options WHERE option_name=\"$optionname\"" \
	  --batch \
	  --skip-column-names
done

exit 0

# vim: noet sw=8 ts=8
