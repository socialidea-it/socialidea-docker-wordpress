## Socialidea Docker for WordPress
**DockerHub: https://hub.docker.com/r/socialideait/wordpress**

Includes:
- [x] wordpress
- [x] mysql
- [x] wp-cli
- [x] phpmyadmin
- [x] mailhog
- [x] composer
- [ ] S3 storage [ coming soon ]
- [ ] SSL
 
### WP-CONFIG.PHP

Customize costants inside docker-compose.yml

```yml
 WORDPRESS_DB_HOST: db
  WORDPRESS_DB_NAME: "${PROJECT}"
  WORDPRESS_DB_USER: root
  WORDPRESS_DB_PASSWORD: "${DB_ROOT_PASSWORD}"

  WORDPRESS_TABLE_PREFIX: wp_
  WORDPRESS_AUTH_KEY: 5f6ede1b94d25a2294e29eeba929a8c80a5ac0fb
  WORDPRESS_SECURE_KEY: 5f6ede1b94d25a2294e29eeba929a8c80a5ac0fb
  WORDPRESS_LOGGED_IN_KEY: 5f6ede1b94d25a2294e29eeba929a8c80a5ac0fb
  WORDPRESS_NONCE_KEY: 5f6ede1b94d25a2294e29eeba929a8c80a5ac0fb
  WORDPRESS_SECURE_AUTH_SALT: 5f6ede1b94d25a2294e29eeba929a8c80a5ac0fb
  WORDPRESS_LOGGED_IN_SALT: 5f6ede1b94d25a2294e29eeba929a8c80a5ac0fb
  WORDPRESS_NONCE_SALT: 5f6ede1b94d25a2294e29eeba929a8c80a5ac0fb

  # our local dev environment
  WORDPRESS_CONFIG_EXTRA: |

    /* development parameters */
    define('WP_CACHE', false);
    define('ENVIRONMENT', 'local');

    /* configure mail server */
    define('WORDPRESS_SMTP_AUTH', false);
    define('WORDPRESS_SMTP_SECURE', '');
    define('WORDPRESS_SMTP_HOST', 'mailhog');
    define('WORDPRESS_SMTP_PORT', '1025');
    define('WORDPRESS_SMTP_USERNAME', null);
    define('WORDPRESS_SMTP_PASSWORD', null);
    define('WORDPRESS_SMTP_FROM', 'no-reply@wordpress.org');
    define('WORDPRESS_SMTP_FROM_NAME', 'Wordpres Site');

    if(!defined('WP_HOME')) {
      define('WP_HOME', 'http://localhost');
      define('WP_SITEURL', WP_HOME);
    }
```

### WP-CLI

```shell
  docker-compose run --rm wpcli user list
```
---
### PHPMYADMIN

URL: localhost:8080

**Default credentials:**\
user `root`\
pass `mysql`

---
### MAILHOG
URL: localhost:8025
```php
add_action( 'phpmailer_init', 'setup' );
function setup( $phpmailer ) {
	$phpmailer->Host = WORDPRESS_SMTP_HOST;
	$phpmailer->From = WORDPRESS_SMTP_FROM;
	$phpmailer->Port = WORDPRESS_SMTP_PORT;
	$phpmailer->FromName = WORDPRESS_SMTP_FROM_NAME;
	$phpmailer->IsSMTP();
}

add_filter( 'wp_mail_from', function( $from ) {
  	return WORDPRESS_SMTP_FROM;
});

add_action('wp_mail_failed', 'log_mailer_errors', 10, 1);
function log_mailer_errors( $wp_error ){
  $fn = ABSPATH . '/wp-content/uploads/mail.log'; // say you've got a mail.log file in your server root
  $fp = fopen($fn, 'a');
  fputs($fp, "Mailer Error: " . $wp_error->get_error_message() ."\n");
  fclose($fp);
}
```
---
### COMPOSER

```shell
docker-compose run --rm composer init
```

---

### S3 STORAGE 

**Coming soon:** https://github.com/silinternational/docker-sync-with-s3
---
### SSL

**Coming soon:** https://zactyh.medium.com/hosting-wordpress-in-docker-with-ssl-2020-fa9391881f3
