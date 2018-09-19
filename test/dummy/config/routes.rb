Rails.application.routes.draw do

  mount PhabAuth::Engine => "/phab_auth"
end
