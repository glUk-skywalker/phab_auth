module PhabAuth
  module ApplicationHelper
    def phab_login_link
      link_to_params = [
        'login via Phabricator',
        phab_login_url
      ]
      link_to *link_to_params
    end

    def phab_login_url
      PhabAuth.verify_settings!
      red_url = main_app.root_url + PhabAuth::Engine.mount_path
      red_url.gsub!('http://', 'https://') if Rails.env.production?
      l_params = {
        client_id: PhabAuth.client_id,
        redirect_uri: red_url,
        response_type: 'code'
      }
      PhabAuth.oauthserver_url + 'oauthserver/auth/' + '?' + URI.encode_www_form(l_params)
    end
  end
end
