# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_thirty_session',
  :secret      => '73d1da3fa989706d91778cef39c654cdde89e2aba4d2fb700a2ec77d8bf9500ef845af50df6c095d684548719e7bd04019d292e5042a5bed222c02bf1fa09a93'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
ActionController::Base.session_store = :active_record_store
