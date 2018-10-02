module PhabAuth
  class SettingAbsent < StandardError
    def initialize(setting)
      super('PhabAuth setting is absent: ' + setting)
    end
  end
end
