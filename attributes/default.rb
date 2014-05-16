default['rabbitmq']['dependencies']['packages'] = %w{
  libxslt
  zip
  unzip
  py27-simplejson
}
default['rabbitmq']['mirror'] = 'http://www.rabbitmq.com/releases/rabbitmq-server'
default['rabbitmq']['version'] = '3.3.1'
