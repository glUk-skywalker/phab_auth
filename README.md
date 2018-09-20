# PhabAuth
This gem is used for simplification the login procedure via third party [phabricator](https://secure.phabricator.com/book/phabricator) server.

## Confituring your Phabricator
To make your app able using your phabricator facilities for authorisation you have to make the corresponding configuration. Please refer to the Phabricator documentation to achieve this.

## Usage
Include the gem to your Gemfile:

    gem 'phab_auth', git:  'https://github.com/glUk-skywalker/phab_auth.git'

Run the `bundle install`  command.
In your `ApplicationController` include `PhabAuth` helpers (so the `phab_login_link` helper is available in your views)

    helper PhabAuth::Engine.helpers

Add the `phab_login_link` call to your login form (haml example):

    = phab_login_link

Add the itinialization for phabricator authorisation:
Create file `config/initializers/phab_auth.rb` with following content:

    PhabAuth.setup do |conf|
      conf.client_id = <clien id>
      conf.client_secret = <client secret>
      conf.oauthserver_url = <phabricator base url>
      conf.create_session_path = < route helper to pass user data to, ex.: :create_session_path>
    end

Mount the gem in your `config/routes.rb` wherever you want:

    mount PhabAuth::Engine, at:  'auth'

Add a route and corresponding controller action that accept the user data brough from phabricator:

    match 'auth/create_session', to:  'sessions#create', via:  :get, as:  'create_session'

In your `create` action of your `SesstionsController` you can access the user data the way below:

    user_info = params[:result][:user_info]

In the case of passed authorisation, `user_info` will contain something like this:

     {
      "phid": "PHID-USER-4ycy5fthhe3iots5wgGl",
      "userName": "connor",
      "realName": "Sarah Connor",
      "image": "https://phabfiles.phabricator.yourcompany.com/file/data/t3hw57v5h2y7ud034qeo/PHID-FILE-j345oo2aft4m4tfg4dc6/profile",
      "uri": "https://phabricator.yourcompany.com/p/connor/",
      "roles": [
        "verified",
        "approved",
        "activated"
      ],
      "primaryEmail": "connor@yourcompany.com"
    }

In case of failed authorisation, please, check the main log of your app. 
Proper error handling will be added later (soon).

## License
This project uses MIT-LICENSE.
