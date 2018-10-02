require 'phab_auth/engine'
require 'phab_auth/exceptions/setting_absent'

module PhabAuth
  class Engine < ::Rails::Engine
    isolate_namespace PhabAuth
  end
end
