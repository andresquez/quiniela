Devise.setup do |config|
  # ...
  
  # Specify the model for Devise to use.
  config.authentication_keys = [:username]
  
  # ...

  # ==> Configuration for :database_authenticatable
  # For bcrypt, this is the cost for hashing the password and defaults to 12. If
  # using other algorithms, it sets how many times you want the password to be hashed.
  # The number of stretches used for generating the hashed password are stored
  # with the hashed password. This allows you to change the stretches without
  # invalidating existing passwords.
  #
  # Limiting the stretches to just one in testing will increase the performance of
  # your test suite dramatically. However, it is STRONGLY RECOMMENDED to not use
  # a value less than 10 in other environments. Note that, for bcrypt (the default
  # algorithm), the cost increases exponentially with the number of stretches (e.g.
  # a value of 20 is already extremely slow: approx. 60 seconds for 1 calculation).
  config.stretches = Rails.env.test? ? 1 : 12

  # Set up a pepper to generate the hashed password.
  # config.pepper = '07f951d5ec147491dcee0bf1293d7f900cc0171f1295952ab04ce4e1eaae5a4eb8ae692218e3b5dcf172be2486385008458a119c390e41b604a0bc42569286da'

  # ...

  # ==> Configuration for :registerable

  # When set to false, does not sign a user in automatically after their password is
  # changed. Defaults to true, so a user is signed in automatically after changing a password.
  # config.sign_in_after_change_password = true

  # Specify the model for Devise to use for registration.
  # In your case, we want to use the Player model for registration.
  config.scoped_views = true
  config.router_name = :players
  config.omniauth_path_prefix = '/players/auth'

  # ...
end
