RedBase::Engine.routes.draw do

  # Authentications
  devise_for :users, {
    :class_name => "RedBase::User",
    :controllers => { :omniauth_callbacks => "red_base/omniauth/callbacks" },
    :module => :devise
  }

  # Root URL
  root :to => "home#index"
end
