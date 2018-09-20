module PhabAuth
  module ApplicationHelper
    def phab_login_link
      red_url = main_app.root_url + PhabAuth::Engine.mount_path
      red_url.gsub!('http://', 'https://') if Rails.env.production?
      l_params = {
        client_id: PhabAuth.client_id,
        redirect_uri: red_url,
        response_type: 'code'
      }
      link_to_params = [
        'login via Phabricator',
        PhabAuth.oauthserver_url + 'oauthserver/auth/' + '?' + URI.encode_www_form(l_params)
      ]
      link_to *link_to_params
    end
  end
end
