wpchurl
=======

Description
-----------

wpchurl changes the address at which a WordPress installation should be reachable. It automates the steps described [here](https://codex.wordpress.org/Changing_The_Site_URL#Changing_the_URL_directly_in_the_database "Changing the URL directly in the database") in the WordPress Codex. Database credentials are borrowed from `wp-config.php`.

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
The options `-S` (Site) and `-H` (WordPress/Home) can be used to leave the respective address untouched.

