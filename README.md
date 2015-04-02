### Wordpress Virtual Hosts

Provides a method of setting up Wordpress virtual hosts that share a single wordpress
codebase, with options for individually configured plugins and themes.


### Quickstart: Example stack config

```
{
	"wordpress_opsworks":{
		"cache_dir":"/var/cache/wordpress_opsworks",
		"content_dir":"/srv/www/wp_content/current",
		"user_dir":"/mnt/user",
		"mysql":{
			"host":"shared-db.aws.com",
			"username":"root",
			"password":"...",
			"schema_file":"schema.tar.bz2"
		},
		"vhosts":{
			"domainone.com":{
				"admin_username":"admin",
				"admin_password":"pass123",
				"editor_username":"editor",
				"editor_password":"321ssap"
				"themes":["theme1","theme2"],
				"plugins":["plugin1","plugin2"],
				"debug":"true",
				"siteurl":"http://domainone.com/wordpress/",
				"home":"http://domainone.com/",
				"blogname":"Name of the Blog",
				"blogdescription":"Description of the Blog",
				"users_can_register":"1",
				"admin_email":"admin@domainone.com",
				"aliases":["sub1.domainone.com","sub2.domainone.com"]
			},
			"domaintwo.com":{ ... },
			"domainthree.com":{ ... }
		},
		"s3":{
			"bucket":"mybucket",
			"id":"your aws access key id",
			"key":"your aws secret key"
		}
	}
}
```

### Custom lifecycle events

Add these recipes to your layer's custom lifecycle events:

- Setup: `wordpress-opsworks` `wordpress-opsworks::setup_wordpress`
- Deploy: `wordpress-opsworks::setup_vhosts`

### Virtual host configuration

`node[:wordpress_opsworks][:vhosts]`

`vhost[:admin_username]` *recommended* Administrator username used for initial setup (default: admin)
`vhost[:admin_password]` *recommended* Administrator password used for initial setup (default: admin)
`vhost[:editor_username]` *recommended* Editor username used for initial setup (default: editor)
`vhost[:editor_password]` *recommended* Editor password used for initial setup (default: editor)
`vhost[:themes]` array of themes to link to the vhost
`vhost[:plugins]` array of plugins to link to the vhost
`vhost[:siteurl]` Site url of blog, used for internal links (default: http://domainname.com/wordpress/)
`vhost[:home]` Home url of blog, (default: http://domainname.com/)
`vhost[:blogname]` Initial blog name
`vhost[:blogdescription]` Initial description
`vhost[:users_can_register]` Allow user registration (0|1)
`vhost[:admin_email]` Administrator contact email
`vhost[:aliases]` array of alias domains
`vhost[:debug]` Enable wordpress debug mode

### TODO

- create database on provision :shipit:
 - import skeleton schema / data :shipit:
 - modify siteurl & home settings :shipit:
 - set default admin user / pass :shipit:
- set up plugins & themes :shipit:
- set up random encryption salts once

### References
- http://codex.wordpress.org/Giving_WordPress_Its_Own_Directory
- http://jason.pureconcepts.net/2013/04/updated-wordpress-multitenancy/
- http://wordpress.stackexchange.com/questions/57109/how-to-share-wordpress-core-library
