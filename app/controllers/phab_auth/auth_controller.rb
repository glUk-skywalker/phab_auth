module PhabAuth
  class AuthController < ApplicationController
    def auth
      if params[:code]
        require 'net/http'
        param = {
          client_id: PhabAuth.client_id,
          client_secret: PhabAuth.client_secret,
          code: params[:code],
          grant_type: 'authorization_code',
          redirect_uri: main_app.root_url + PhabAuth::Engine.mounted_path
        }
        uri = URI(PhabAuth.oauthserver_url + '/oauthserver/token/?' + URI.encode_www_form(param))
        uri.path.gsub!(%r{\/+}, '/')
        t = JSON.parse(Net::HTTP.get(uri))['access_token']
        if t
          uri = URI(PhabAuth.oauthserver_url + "/api/user.whoami?access_token=#{t}")
          uri.path.gsub!(%r{\/+}, '/')
          user_info = JSON.parse(Net::HTTP.get(uri))['result']
        end
      end
      redirect_to main_app.send(PhabAuth.create_session_path, result: { user_info: user_info })
    end
  end
end
