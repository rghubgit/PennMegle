// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    this.apiKey = this.data.get("api-key")
    this.sessionId = this.data.get("session-id")
    this.token = this.data.get("token")
    this.initializeSession()
    console.log('yea')
  }

  handleError(error) {
    if (error) {
      alert(error.message);
    }
  }
  
  // (optional) add server code here
  initializeSession();
  
  initializeSession() {
    var session = OT.initSession(this.apiKey, this.sessionId);
  
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
  

  // connect() {
  //   this.apiKey = this.data.get("api-key")
  //   this.sessionId = this.data.get("session-id")
  //   this.token = this.data.get("token")
  //   this.initializeSession()
  //   console.log('yea')
  // }

  // disconnect() {
  //   if (this.session) {
  //     this.session.disconnect()
  //   }
  // }

  // initializeSession() {
  //   this.session = OT.initSession(this.apiKey, this.sessionId)
  //   this.session.on('streamCreated', this.streamCreated.bind(this))

  //   this.publisher = OT.initPublisher(this.element, {
  //     insertMode: 'append',
  //     width: '100%',
  //     height: '100%',
  //     name: this.data.get("name"),
  //   }, this.handleError.bind(this))

  //   this.session.connect(this.token, this.streamConnected.bind(this))
  // }

  // streamConnected(error) {
  //   if (error) {
  //     this.handleError(error)
  //   } else {
  //     this.session.publish(this.publisher, this.handleError.bind(this))
  //   }
  // }

  // streamCreated(event) {
  //   this.session.subscribe(event.stream, this.element, {
  //     insertMode: 'append',
  //     width: '100%',
  //     height: '100%',
  //   }, this.handleError.bind(this))
  // }

  // handleError(error) {
  //   if (error) {
  //     console.error(error.message)
  //   }
  // }
}
