<?php
// ** MySQL settings - This info is saved inside your .env ** //
// The name of the database for WordPress
// define('DB_NAME', '${WP_DATABASE_NAME}');	 # Manully changed this!!!!!!!!!!!!
define('DB_NAME', 'wordpress');

// MySQL database username
// define('DB_USER', '${DB_USER}');	 # Manully changed this!!!!!!!!!!!!
define('DB_USER', 'bob');

// MySQL database password
// define('DB_USER_PASSWORD', '${DB_USER_PASSWORD}');	 # Manully changed this!!!!!!!!!!!!
define('DB_USER_PASSWORD', 'bob');

// MySQL hostname (Database for the server)
define('DB_HOST', 'mariadb');            # Manully changed this!!!!!!!!!!!!

// Database Charset to use in creating database tables.
define('DB_CHARSET', 'utf8');

// The Database Collate type.
define('DB_COLLATE', '');

// ** Authentication Unique Keys and Salts. ** //
// Find generated key here: https://api.wordpress.org/secret-key/1.1/salt/ 
define('AUTH_KEY',         '8EsCDOM}7G%]D<90c]-+TzD%w=_M0CoY1~$5id>.JPO({DW~i}0x!}Z5X2>H|dly');
define('SECURE_AUTH_KEY',  '|Ety5|C 8qA^t3>>kYI}6Zm)c%&HjVK[|qd(C;GGp?9kb;)2#-J[KUH-_g4aAl;=');
define('LOGGED_IN_KEY',    '7wEU[#J(-u27qaPl+a.)OdLv(.3U_m<SKMVvn90Ia)Mwd)|1j3P5{dVWk-6%:E6<');
define('NONCE_KEY',        '?DCZ?J_lRJq0[j@xhO8bQ<|Is<0L&WOncGPL<8L$-hkI,`^?Xk=;~5t~wy%z2*}+');
define('AUTH_SALT',        '/5iNnxCVI,Mwk-@@+i!aVmo~*])8l-Zeitu0+^ip lvp088s^3J[%|-#|R)-<wi$');
define('SECURE_AUTH_SALT', '&X>]HbfAq.^JtJ=20N+Q}od-[Z:szi<(4;fs/A$sFCR(}^WLNPH=2,+k80-bLqyT');
define('LOGGED_IN_SALT',   'zC{Fhx#4L5GxU5)Tu4$4>iiV.V}.|}  %lVL&V*?DB}!pIm(6(QFe^|sS#>$U<{8');
define('NONCE_SALT',       'ao;c@w@)!D@ujk+]D7O2 ?@T8b)il~LRzM|:ac`ykb;K;+.8/Yo4tf]X|R~+t+*5');

// Defines the prefix for WordPress database tables
$table_prefix = 'wp_';

define( 'WP_DEBUG', true );

// Absolute path to the WordPress directory.
if ( ! defined( 'ABSPATH' ) ) {
	define('ABSPATH', __DIR__ . '/');
	// define( 'ABSPATH', '/var/www/html/wordpress/' ); // Could also use this
}

// Sets up WordPress vars and included files.
require_once ABSPATH . 'wp-settings.php';
