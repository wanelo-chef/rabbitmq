name             'rabbitmq'
maintainer       'Wanelo, Inc'
maintainer_email 'ops@wanelo.com'
license          'MIT'
description      'Installs/Configures rabbitmq'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.3.0'

depends 'build-essential'
depends 'erlang'
depends 'python'

supports 'smartos'
