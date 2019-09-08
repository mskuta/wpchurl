Description
===========

wpchurl changes the address at which a WordPress installation should be reachable. It automates the steps described [here](https://codex.wordpress.org/Changing_The_Site_URL#Changing_the_URL_directly_in_the_database "Changing the URL directly in the database") in the WordPress Codex.


Installation
============

- Clone this repository.
- Run the included installation script by entering `sudo ./install.sh`. The default target directory for the executable is `/usr/local/bin`. Use the environment variable `PREFIX` to change this. For example, to install the software under your home directory, type `PREFIX=$HOME/.local ./install.sh` and make sure `$HOME/.local/bin` is in your `$PATH`.

Debian and derivatives (f. e. Ubuntu) 
-------------------------------------

- Download the latest .deb package from the Releases page.
- Install it by entering `sudo dpkg --install <.deb file name>`.


Usage
=====

```shell
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


