rabbitmq Cookbook
=================

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
