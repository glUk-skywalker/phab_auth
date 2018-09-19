PhabAuth::Engine.routes.draw do
  match '/', to: 'auth#auth', via: :get
end
