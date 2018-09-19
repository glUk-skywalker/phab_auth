module PhabAuth
  class Engine < ::Rails::Engine
    isolate_namespace PhabAuth

    def self.mounted_path
      route = Rails.application.routes.routes.detect do |route|
        route.app == self
      end
      (route && route.path).spec.to_s.delete('/')
    end
  end

  class << self
    mattr_accessor :client_id, :client_secret, :oauthserver_url, :create_session_path
    self.client_id = nil
    self.client_secret = nil
    self.oauthserver_url = nil
    self.create_session_path = nil
  end

  def self.setup(&block)
    yield self
  end
end
