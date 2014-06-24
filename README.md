rabbitmq Cookbook
=================

This cookbook acts as an in-place replacement for the Opscode RabbitMQ 

## Providers

#### rabbitmq_user

```ruby
rabbitmq_user 'username' do
  password 'mypassword'
  vhost '/thing'
  permissions '.* .* .*'
  action :create
end
```

#### rabbitmq_plugin

```ruby
rabbitmq_plugin 'rabbitmq_management' do
  action :enable
end
```
