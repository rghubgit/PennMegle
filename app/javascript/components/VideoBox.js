import React from "react"
import PropTypes from "prop-types"

// export default function VideoBox(props) {
//   const apiKey = props.apiKey;
//   const sessionId = props.sessionId;
//   const token = props.token;

//   // Handling all of our errors here by alerting them
//   function handleError(error) {
//     if (error) {
//       alert(error.message);
//     }
//   }

//   // (optional) add server code here
//   initializeSession();

//   function initializeSession() {
//     var session = OT.initSession(apiKey, sessionId);

//     // Subscribe to a newly created stream
//     session.on('streamCreated', function(event) {
//       session.subscribe(event.stream, 'subscriber', {
//         insertMode: 'append',
//         width: '100%',
//         height: '100%'
//       }, handleError);
//     });

//     // Create a publisher
//     var publisher = OT.initPublisher('publisher', {
//       insertMode: 'append',
//       width: '100%',
//       height: '100%'
//     }, handleError);

//     // Connect to the session
//     session.connect(token, function(error) {
//       // If the connection is successful, initialize a publisher and publish to the session
//       if (error) {
//         handleError(error);
//       } else {
//         session.publish(publisher, handleError);
//       }
//     });
//   }

//   return (
//     <div>
//       {apiKey}
//       hi
//     </div>
//   )
// }

class VideoBox extends React.Component {
  render () {
    return (
      <div>
        <React.Fragment>
        Api Key: {this.props.apiKey}
        Session: {this.props.sessionId}
        Token: {this.props.token}
      </React.Fragment>

        <h1>bro</h1>
      </div>
    );
  }
}

VideoBox.propTypes = {
  apiKey: PropTypes.string,
  sessionId: PropTypes.string,
  token: PropTypes.string
};
export default VideoBox
