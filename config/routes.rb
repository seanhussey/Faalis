RedBase::Engine.routes.draw do

  # Authentications
  devise_for :users, {
    :class_name => "RedBase::User",
    :controllers => { :omniauth_callbacks => "redbase/users/omniauth_callbacks" },
    :module => :devise
  }

  # Root URL
  root :to => "home#index"
end
