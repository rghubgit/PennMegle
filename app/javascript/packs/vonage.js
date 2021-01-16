// replace these values with those generated in your TokBox Account
var apiKey = "47005474";
var sessionId = "2_MX40NzAwNTQ3NH5-MTYwNjQyNTgxMTg4Mn5oZ2VoM3FoYTlVdHNIekwyS2ZyQVUyVE9-fg";
var token = "T1==cGFydG5lcl9pZD00NzAwNTQ3NCZzaWc9MjllODljYjUyY2E1ZDVlY2U1OTgxY2Q5YzZlMzNiMzNiNmEwYTMxYTpzZXNzaW9uX2lkPTJfTVg0ME56QXdOVFEzTkg1LU1UWXdOalF5TlRneE1UZzRNbjVvWjJWb00zRm9ZVGxWZEhOSWVrd3lTMlp5UVZVeVZFOS1mZyZjcmVhdGVfdGltZT0xNjA2NDI1ODM2Jm5vbmNlPTAuNTA2MDc2NDA2NjcyNDkxMiZyb2xlPXB1Ymxpc2hlciZleHBpcmVfdGltZT0xNjA2NDI5NDM0JmluaXRpYWxfbGF5b3V0X2NsYXNzX2xpc3Q9";

// Handling all of our errors here by alerting them
function handleError(error) {
  if (error) {
    alert(error.message);
  }
}

// (optional) add server code here
initializeSession();

function initializeSession() {
  var session = OT.initSession(apiKey, sessionId);

  // Subscribe to a newly created stream
  session.on('streamCreated', function(event) {
    session.subscribe(event.stream, 'subscriber', {
      insertMode: 'append',
      width: '100%',
      height: '100%'
    }, handleError);
  });

  // Create a publisher
  var publisher = OT.initPublisher('publisher', {
    insertMode: 'append',
    width: '100%',
    height: '100%'
  }, handleError);

  // Connect to the session
  session.connect(token, function(error) {
    // If the connection is successful, initialize a publisher and publish to the session
    if (error) {
      handleError(error);
    } else {
      session.publish(publisher, handleError);
    }
  });
}
