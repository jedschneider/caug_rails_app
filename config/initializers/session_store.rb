# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_flu_reporter_session',
  :secret      => '5aaf2c2d581249003466c377ec54a7c1d3a39a30b6653eb9fccea5eb49f1fc792854e2561f3f0760954bb08ae97f5e4609b3dd7d1eeae72949bbee589c0383b1'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
