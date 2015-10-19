# AnyLogin Gem
[<img src="https://travis-ci.org/igorkasyanchuk/any_login.svg?branch=master"
alt="Build Status" />](https://travis-ci.org/igorkasyanchuk/any_login) [<img
src="https://codeclimate.com/github/igorkasyanchuk/any_login/badges/gpa.svg"
/>](https://codeclimate.com/github/igorkasyanchuk/any_login) [<img
src="https://badge.fury.io/rb/any_login.svg" alt="Gem Version"
/>](http://badge.fury.io/rb/any_login)

## Description

**Demo** available on: https://any-login.herokuapp.com (source code for demo
https://github.com/igorkasyanchuk/any_login_test)

**Video Demo**: https://youtu.be/978DlHvufSY


[<img src="https://i.ytimg.com/vi/978DlHvufSY/hqdefault.jpg"
/>](https://youtu.be/978DlHvufSY)

AnyLogin is created to speedup development process and allow developer's
quickly login as any user in DB.

Give it a try and if you like it share with friends. In case you have any suggestions please feel free to contact me.

## Requirements
Ruby: 1.9.3, 2.X, Rails: >= 4.0. Works in pair with **Devise**, **Authlogic**, **Clearance** or **Sorcery** gems.

## Installation

 1. List  Add to your Gemfile:

        gem 'any_login'

 2. Execute in console:

        bundle install

 3. In application layout (for example `app/views/layouts/application.html.erb`) add in the bottom of the page:

        <%= any_login_here %>

 4. Open your app and on the bottom left corner you will see semi-transparent user icon. Click on it and now you can select any user to login without password.

## Integrations

### Devise

By default doesn't require any additional steps to make it works with Devise gem. If you have model `User` everything should works fine. In case you have other model you need to set it in options (see Customization section).

### Authlogic

By default doesn't require any additional steps to make it works with Authlogic gem. If you have model `User` and you have `current_user` method in application controller everything should works fine. In case you have other model you need to set it in options (see Customization section).

### Clearance

By default doesn't require any additional steps to make it works with Clearance gem. If you have model `User` everything should works fine. In case you have other model you need to set it in options (see Customization section).

### Sorcery

By default doesn't require any additional steps to make it works with Sorcery gem. If you have model `User` everything should works fine. In case you have other model you need to set it in options (see Customization section).


## Customization
If you want to customize gem run in console:

    rails g any_login initializer

If will create file config/initializers/any_login.rb.

### Options
*   **enabled** - enable of disable gem (by default this gem is enabled only in development mode).
*   **klass_name** - class name for "User" object. Default to `User`.
*   **collection_method** - method which returns collection of users. Sample:
    `.all`, `.active`, `.admins`, `.groupped_users`. Value is a simple.
    Default to `:all`.
*   **name_method** - default value is `proc { |e| [e.email, e.id] }`. You can
    change label for select in dropdown. For example you can add roles,
    permissions and any other important information.
*   **limit** - limit number of records in dropdown. Default 10. You can put
    `:none` if you don't want to limit number of users for select.
*   **redirect_path_after_login** - redirect user to path. Default is
    `:root_path`.
*   **login_on** - you can enable login with select field, ID input or both.
    Default: `:both`.
*   **position** - position of any_login box on page. Possible values: `top_left`,
    `top_right`, `bottom_left`, `bottom_right`. Default: `bottom_left`.
*   **login_button_label** - login button label.
*   **select_prompt** - select prompt message.
*   **auto_show** - automatically show any_login box.
*   **http_basic_authentication_enabled** - Enable HTTP_BASIC authentication.
*   **http_basic_authentication_user_name** - HTTP_BASIC authentication user name.
*   **http_basic_authentication_password** - HTTP_BASIC authentication password.


### Advanced Options
If you want to add collection grouped for example by role you can do it with:

    def self.groped_collection_by_role
      {
        'admin' => User.limit(10),
        'moderator' => User.limit(10),
        'user' => User.limit(10)
      }
    end

And in config/initializers/any_login.rb add `config.collection_method =
:groped_collection_by_role`.

## Production
If you want to completely disable gem in production add following code in your
config/environments/production.rb file.

    AnyLogin.setup do |config|
       config.enabled = false
    end

You can also try to debug you application in production and secure any_login with HTTP_BASIC authentication. See Options sections for more details.

## Future Plans
1.  Add tests
2.  Add support for more authentication gems like Devise, Authlogic, Clearance (restful_authentication, monban, letmein)

