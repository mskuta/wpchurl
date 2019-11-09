Description
===========

wpchurl changes the address at which a WordPress installation should be reachable. It automates the steps described [here](https://wordpress.org/support/article/changing-the-site-url/#changing-the-url-directly-in-the-database "Changing the URL directly in the database") on the official WordPress website.


Installation
============

1. Clone this repository: `git clone https://github.com/mskuta/wpchurl.git`
2. Run the included installation script: `sudo wpchurl/install.sh`

The default target directory for the executable is `/usr/local/bin`. Use the environment variable `PREFIX` to change this. For example, to install the software under your home directory, enter `PREFIX=$HOME/.local wpchurl/install.sh` and make sure `$HOME/.local/bin` is in your `$PATH`.

Debian and derivatives (Ubuntu, Raspbian, etc.) 
-----------------------------------------------

1. Download the latest .deb package from the [Releases](https://github.com/mskuta/wpchurl/releases/latest) page.
2. Install it: `sudo dpkg --install wpchurl_x.y.z_all.deb`


Usage
=====

```
Usage:
  wpchurl [-d DIRECTORY]
  wpchurl [-d DIRECTORY] [-HS] URL
Options:
  -H  Do not change the WordPress Address ("home").
  -S  Do not change the Site Address ("siteurl").
  -d  Directory containing the WordPress files.

If no DIRECTORY is specified, the current one will be used.
If no URL is specified, just the active settings will be displayed.
```

Credentials to access the database do not have to be specified. They are taken from the file `wp-config.php`, which is part of every WordPress installation.

Examples
--------

Display the current settings for "Site Address" and "WordPress Address":
```shell
wpchurl -d /var/www/mysite
```

Set both addresses to a different value:
```shell
wpchurl -d /var/www/mysite https://www.newname.com
```


License
=======

This software is distributed under the ISC license.


