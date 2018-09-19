module PhabAuth
  module ApplicationHelper
    def phab_login_link
      l_params = {
        client_id: PhabAuth.client_id,
        redirect_uri: request.base_url + '/' + PhabAuth::Engine.mounted_path,
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
