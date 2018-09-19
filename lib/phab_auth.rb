require 'phab_auth/engine'

module PhabAuth
  class Engine < ::Rails::Engine
    isolate_namespace PhabAuth
  end
end
