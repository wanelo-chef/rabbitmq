rabbitmq Cookbook
=================

This cookbook acts as an in-place replacement for the Opscode RabbitMQ 

## Providers

#### rabbitmq_vhost

```ruby
rabbitmq_vhost 'thing'
```

#### rabbitmq_user

```ruby
rabbitmq_user 'username' do
  password 'mypassword'
  vhost '/thing'
  permissions '.* .* .*'
  action :create
end
```

Note that currently the cookbook requires a password to be set for any
RabbitMQ user created.

#### rabbitmq_plugin

```ruby
rabbitmq_plugin 'rabbitmq_management' do
  action :enable
end
```
