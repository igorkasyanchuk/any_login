# AnyLogin Gem

[![Tests](https://github.com/igorkasyanchuk/any_login/actions/workflows/ci.yml/badge.svg)](https://github.com/igorkasyanchuk/any_login/actions/workflows/ci.yml)
[<img
src="https://codeclimate.com/github/igorkasyanchuk/any_login/badges/gpa.svg"
/>](https://codeclimate.com/github/igorkasyanchuk/any_login) [<img
src="https://badge.fury.io/rb/any_login.svg" alt="Gem Version"
/>](http://badge.fury.io/rb/any_login)
[![RailsJazz](https://github.com/igorkasyanchuk/rails_time_travel/blob/main/docs/my_other.svg?raw=true)](https://www.railsjazz.com)
[![https://www.patreon.com/igorkasyanchuk](https://github.com/igorkasyanchuk/rails_time_travel/blob/main/docs/patron.svg?raw=true)](https://www.patreon.com/igorkasyanchuk)

## Description

**Demo** available on: https://any-login.herokuapp.com (source code for demo
https://github.com/igorkasyanchuk/any_login_test)

**Video Demo**: https://youtu.be/978DlHvufSY

[<img src="https://i.ytimg.com/vi/978DlHvufSY/hqdefault.jpg"
/>](https://youtu.be/978DlHvufSY)

AnyLogin was created to speed up the development process by allowing developers to quickly log in as any user.

Give it a try; if you like it please share AnyLogin with friends. If you have any suggestions please feel free to contact me.

## Requirements

Ruby: 1.9.3, 2.X, Rails: >= 4.0. Pre-configured to work with **Devise**, **Authlogic**, **Clearance** or **Sorcery** gems.

For Rails < 4.2.7 please use `gem 'any_login', '1.3'`.

## Installation

1.  Add AnyLogin to your Gemfile:

        gem 'any_login'

2.  Execute in console:

        bundle install

3.  In application layout (for example `app/views/layouts/application.html.erb`) add the following to the bottom of the page:

        = any_login_here if defined?(AnyLogin)

4.  Open your app and on the bottom left corner you will see semi-transparent user icon. Click on it and now you can select any user to log in as without a password.

## Integrations

### Mongoid

After defining a class method called `primary_key`, `any_login` works seamlessly. Otherwise, you will see this error `undefined method 'primary_key' for User:Class`

```ruby
class User
  ...

  class << self
    def primary_key
      # if your primary key is :id, if anything else use accordingly.
      :id
    end
  end
end
```

### Devise

By default no additional steps are required to make it work with Devise gem. If you have a `User` model everything should work fine. If you have different user model you need to set it in options (see Customization section).

### Authlogic

By default no additional steps are required to make it work with Authlogic gem. If you have a `User` model and a `current_user` method in application controller everything should work fine. If you have different user model you need to set it in options (see Customization section).

### Clearance

By default no additional steps are required to make it work with Clearance gem. If you have a `User` model everything should work fine. If you have different user model you need to set it in options (see Customization section).

### Sorcery

By default no additional steps are required to make it work with Sorcery gem. If you have a `User` model everything should work fine. If you have different user model you need to set it in options (see Customization section).

### Custom Providers

If you are utilizing a custom login strategy, you can also utilize it with this gem. Below is an example configuration if a user was utilizing OmniAuth and rails sessions directly as described in [this article](http://railscasts.com/episodes/241-simple-omniauth-revised):

In `app/lib/anylogin_omniauth.rb`
```
module AnyloginOmniauth
  module Controller
    def self.any_login_current_user_method(klass)
      @@any_login_current_user_method ||= "current_#{klass.to_s.parameterize.underscore}".to_sym
    end

    def any_login_sign_in
      session[:user_id] = user_id
      redirect_to main_app.send(AnyLogin.redirect_path_after_login)
    end
  end
end
```

Then in your initializer configure `provider` to your new class. In this example it would be `config.provider = "AnyloginOmniauth"`

## Customization

If you want to customize gem execute in console:

    rails g any_login initializer

It will create the initializer file `config/initializers/any_login.rb`.

### Options

- **enabled** - enable or disable gem (by default this gem is enabled only in development mode).
- **klass_name** - class name for "User" object. Defaults to `User`. An array of class names is also supported.
- **collection_method** - method which returns collection of users. Sample:
  `.all`, `.active`, `.admins`, `.groupped_users`. Value is a simple.
  Defaults to `:all`.
- **name_method** - default value is `proc { |e| [e.email, e.id] }`. You can
  change the label of users displayed in dropdown. For example you can add roles,
  permissions and any other important information.
- **limit** - limit number of records in dropdown. Default 10. You can put
  `:none` if you don't want to limit the number of users for select.
- **redirect_path_after_login** - redirect user to path. Default is
  `:root_path`.
- **login_on** - you can enable login with select field, ID input or both.
  Default: `:both`.
- **position** - position of AnyLogin box on page. Possible values: `top_left`,
  `top_right`, `bottom_left`, `bottom_right`. Default: `bottom_left`.
- **login_button_label** - login button label.
- **select_prompt** - select prompt message.
- **auto_show** - automatically show AnyLogin box.
- **http_basic_authentication_enabled** - Enable HTTP_BASIC authentication.
- **http_basic_authentication_user_name** - HTTP_BASIC authentication user name.
- **http_basic_authentication_password** - HTTP_BASIC authentication password.
- **verify_access_proc** - controller based access (condition on request.remote_ip, current_user, etc.)
- **previous_limit** - specify limit of records for history. Default: 6.
- **provider** - Manually specify the login provider, one of Authlogic, Clearance, Devise, Sorcery, or a custom handler class name (as a string or symbol).

### Advanced Options

If you want to display users grouped by role you can do it with:

```ruby
# Initializer: config/initializers/any_login.rb
AnyLogin.setup do |config|
  config.collection_method = :grouped_collection_by_role
end

# User class: app/models/user.rb
class User < ActiveRecord::Base
  def self.grouped_collection_by_role
    {
      'admin'     => User.admins.limit(10),
      'moderator' => User.moderators.limit(10),
      'user'      => User.users.limit(10)
    }
  end
end
```

Or another sample:

```ruby
# Initializer: config/initializers/any_login.rb
AnyLogin.setup do |config|
  config.collection_method = :grouped_users
  # to format user name in dropdown list
  config.name_method = :any_login_name
end

# User class: app/models/user.rb
class User < ActiveRecord::Base
  def any_login_name
    [full_name + ' - ' + email + " Domains: #{domains.collect(&:short_code).join(',').presence || 'none'}; Role: #{role}; ID: #{id}", id]
  end

  def self.grouped_users
    Organization.ordered.includes(:employees).inject({}) do |res, org|
      res[org.name] = org.employees.ordered.includes([:domains, :organization])
      res
    end
  end
end
```

## Production

If you want to completely disable gem in production add following code in your `config/environments/production.rb` file.

```ruby
AnyLogin.setup do |config|
  config.enabled = false
end
```

You can also try to debug your application in production and secure AnyLogin with HTTP_BASIC authentication. See Options sections for more details.

## Future Plans

1.  Add tests
2.  Add support for more authentication gems like Devise, Authlogic, Clearance (restful_authentication, monban, letmein)

## Contributors

- @incubus
- @bbenezech
- @manastyretskyi
- @saiqulhaq
- @zorab47
- @shivabhusal
- @eliotsykes
- @sviatoslav-krupa
- @daichirata
- @linshaodongsam
- @jr180180
- @vmyts539
- @rbclark
- @OskarsEzerins
- @kyohah

## For CI

Update gemspec:

```
bundle
BUNDLE_GEMFILE=./gemfiles/rails_6_1.gemfile bundle
BUNDLE_GEMFILE=./gemfiles/rails_6.gemfile bundle
BUNDLE_GEMFILE=./gemfiles/rails_7.gemfile bundle
```

## Other

[<img src="https://github.com/igorkasyanchuk/rails_time_travel/blob/main/docs/more_gems.png?raw=true"
/>](https://www.railsjazz.com/?utm_source=github&utm_medium=bottom&utm_campaign=any_login)
