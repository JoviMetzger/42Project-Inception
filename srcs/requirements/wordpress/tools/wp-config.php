<?php
// ** MySQL settings - This info is saved inside your .env ** //
// The name of the database for WordPress
define('DB_NAME', 'wordpress');

// MySQL database username
define('DB_USER', 'bob');

// MySQL database password
define('DB_USER_PASSWORD', 'bob');

// MySQL hostname (Database for the server)
define('DB_HOST', 'mariadb');

// Database Charset to use in creating database tables.
define('DB_CHARSET', 'utf8');

// The Database Collate type.
define('DB_COLLATE', '');

// ** Authentication Unique Keys and Salts. ** //
// Find generated key here: https://api.wordpress.org/secret-key/1.1/salt/ 
define('AUTH_KEY',         'Hu+b!Df.$!p/-9mkHSw{qey-O}J_S`uPhl1&$D+ug/p}Y=%BC=t22E9M;~+V6B/3');
define('SECURE_AUTH_KEY',  'K^B%!k*2_iKonTj+`?6goa:;%!Z^>|yu%IZ%q|FT_/KH2R[?4MQE4/2M8R0v[kWd');
define('LOGGED_IN_KEY',    '-`s8q2ra35oQ7m%9ok@n;)^wjW?N|UTyABg[;E|!QCipYK%.86PPKj2i/m1Qy~xF');
define('NONCE_KEY',        'i e<UN5b[ax;~+nkcf9obsU8%T6%_GOI2VBH~ef?w,Zy]g&HdV GcS@`B]EQWzaf');
define('AUTH_SALT',        '[+e^DpSjtV~]GwezM $oP6<+;{p!DP/IiA3fEJ8Zc}|VfayabG|-msE}dg,0g% i');
define('SECURE_AUTH_SALT', '`cWCC|_r!(ud]W;t>aRY5)!XT~^ 5([-Q/8,EdV)c;qHMC{iu>QBYKs5;Auf1a38');
define('LOGGED_IN_SALT',   'ZYkTI8Z4NLeVpwO3eoU~XZ+9+I#q#%2G<<3jk.*It{DvRJ3w=U:b*}=tV^H2-E_S');
define('NONCE_SALT',       'QI0 wCzBek3#9Z8)@A[Q12GLIOdG[gHAR=ck9PH%P;OXR|RkYHlVBZ)Msvf,HsLR');

// Defines the prefix for WordPress database tables
$table_prefix = 'wp_';

define( 'WP_DEBUG', true );

// Absolute path to the WordPress directory.
if ( ! defined( 'ABSPATH' ) ) {
	// define('ABSPATH', __DIR__ . '/');
	define( 'ABSPATH', '/var/www/html/wordpress/' ); // Could also use this
}

// Sets up WordPress vars and included files.
require_once ABSPATH . 'wp-settings.php';
