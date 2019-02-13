module PhabAuth
  class AuthController < ApplicationController
    def auth
      redirect_to(main_app.root_url) && return if session[:user_id]
      if params[:code]
        require 'net/http'
        red_url = main_app.root_url + PhabAuth::Engine.mount_path
        red_url.gsub!('http://', 'https://') if Rails.env.production?
        logger.info('Phabricator redirect uri: ' + red_url.to_s)
        param = {
          client_id: PhabAuth.client_id,
          client_secret: PhabAuth.client_secret,
          code: params[:code],
          grant_type: 'authorization_code',
          redirect_uri: red_url
        }
        uri = URI(PhabAuth.oauthserver_url + '/oauthserver/token/?' + URI.encode_www_form(param))
        uri.path.gsub!(%r{\/+}, '/')

        resp_parsed = JSON.parse(Net::HTTP.get(uri))
        t = resp_parsed['access_token']
        logger.fatal(resp_parsed.to_s) unless t

        uri = URI(PhabAuth.oauthserver_url + "/api/user.whoami?access_token=#{t}")
        uri.path.gsub!(%r{\/+}, '/')

        resp_parsed = JSON.parse(Net::HTTP.get(uri))
        user_info = resp_parsed['result']
        logger.fatal(resp_parsed.to_s) unless user_info
      end
      redirect_to main_app.send(PhabAuth.create_session_path, result: { user_info: user_info })
    end
  end
end
