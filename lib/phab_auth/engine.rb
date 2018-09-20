module PhabAuth
  class Engine < ::Rails::Engine
    isolate_namespace PhabAuth

    def self.mount_path
      routes.find_script_name({})[1..-1]
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
