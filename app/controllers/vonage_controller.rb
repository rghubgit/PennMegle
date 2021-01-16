gem "opentok", "~> 4.0.0"

class VonageController < ApplicationController
  opentok = OpenTok::OpenTok.new 47005474, eaaf27346c9f9b4183bd3feed5675f825484f19b

# ----- Creating Sessions -----

  ## Create a session that will attempt to transmit streams directly between clients.
  ## If clients cannot connect, the session uses the OpenTok TURN server:
  session = opentok.create_session

  ## A session that will use the OpenTok Media Server:
  session = opentok.create_session :media_mode => :routed

  ## A session with a location hint:
  session = opentok.create_session :location => '12.34.56.78'

  ## A session with automatic archiving (must use the routed media mode):
  session = opentok.create_session :archive_mode => :always, :media_mode => :routed

  ## Store this sessionId in the database for later use:
  session_id = session.session_id

# ----- Generating Tokens -----

  ## Generate a Token from just a session_id (fetched from a database)
  token = opentok.generate_token session_id

  ## Generate a Token by calling the method on the Session (returned from createSession)
  token = session.generate_token

  ## Set some options in a token
  token = session.generate_token({
      :role        => :moderator,
      :expire_time => Time.now.to_i+(7 * 24 * 60 * 60), # in one week
      :data        => 'name=Johnny',
      :initial_layout_class_list => ['focus', 'inactive']
  });

end