<?php
// ** MySQL settings - This info is saved inside your .env ** //
// The name of the database for WordPress
define('DB_NAME', 'wordpress');

// MySQL database username
define('DB_USER', 'user');

// MySQL database password
define('DB_PASSWORD', 'user');

// MySQL hostname (Database for the server)
define('DB_HOST', 'mariadb');

// Database Charset to use in creating database tables.
define('DB_CHARSET', 'utf8');

// The Database Collate type.
define('DB_COLLATE', '');


// !!! ---------- FIX ^^^^ ---------- !!!


// ** Authentication Unique Keys and Salts. ** //
// Find generated key here: https://api.wordpress.org/secret-key/1.1/salt/ 
define('AUTH_KEY',         'fzf#`/XEP-@vfB^#X15b6@aSIw]a|Aq+cp2tu9T`MI >(:Y$WA:|~U|-g>>I}%s?');
define('SECURE_AUTH_KEY',  'wi(oYxZe|+d+TS]QD#)e`-T[`M&F6t?-3Ek-$+cJaN6*6}(j*qB>C;hx8z4QW@ya');
define('LOGGED_IN_KEY',    'iz%P4z).Arg?GJ]<ZPwf6 F7B^aq-rqj0G3Wh.}[y1qs+HB+e2nfV0VO.5G0!Hg^');
define('NONCE_KEY',        'YA@V;pA>:/}R_%,;Cison+fg`d~Mi}AO.qp] )VQtw2z)RXd-3Fa7S>)t)xQ;X!+');
define('AUTH_SALT',        'TgBOHm}Bc~3-S*iwhsQ7t7c+&v5lf(55f^qs6&Z7f(p%xk0!n-.k3&,N%^UEI|wZ');
define('SECURE_AUTH_SALT', 'ZLQ)Nbo+/xJytzV,U8REKSQ6%4U(EtV8cnGA1u3D]XeAB!|4,]f87b7l8+}lz#-I');
define('LOGGED_IN_SALT',   'Qnd_i`[A!Fm6PTi|4Z.c4VZmO(-/+T_|XR-nA3i1h3!venYIf=Q&v<t/`(Oxw~W+');
define('NONCE_SALT',       'EkV@=qbWlotAG;Hs?iz55Nf/hsUHjdo5a}ieA+]%bn?V{SH|[[+#GW^o/g+DF`aE');

// Defines the prefix for WordPress database tables
$table_prefix = 'wp_';

// define( 'WP_DEBUG', true );

// Absolute path to the WordPress directory.
if ( ! defined( 'ABSPATH' ) ) {
	define('ABSPATH', __DIR__ . '/');
	// define( 'ABSPATH', '/var/www/html/wordpress/' ); // Could also use this
}

// Sets up WordPress vars and included files.
require_once ABSPATH . 'wp-settings.php';

?>