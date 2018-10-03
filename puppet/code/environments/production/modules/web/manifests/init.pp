class web {
        
	case $::osfamily{
                "RedHat": {
                        $pacote = "httpd"

			service{'firewalld':
				ensure => stopped,
				enable => false
			}
                }
                "Debian": {
                        exec{"atualiza_pacotes_2":
                                command => "/usr/bin/apt update"
                        }
                        $pacote = "apache2"
                }
        }

        package{$pacote:
                ensure => present
        }

	service{$pacote:
		ensure => running
        }

	file{'/var/www/html/puppet.html':
		source => 'puppet:///modules/web/index.html',
		ensure => present
	}

}

