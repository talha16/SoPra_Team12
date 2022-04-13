import React from 'react';
import { BrowserRouter as Router, Route, Redirect } from 'react-router-dom';
import { Container, ThemeProvider, CssBaseline } from '@material-ui/core';
import firebase from 'firebase/compat/app';
import 'firebase/compat/auth';
import SignIn from './SignIn';
import Start from './Start';

/**
 * The main bank administration app. It uses Googles firebase to log into the bank end. For routing the 
 * user to the respective pages, react-router-dom ist used.
 *
 @see See Google [firebase.auth()](https://firebase.google.com/docs/reference/js/firebase.auth.Auth)
 @see See Google [firebase.auth().signInWithRedirect](https://firebase.google.com/docs/reference/js/firebase.auth.Auth#signinwithredirect)
 @see [react-router-dom](https://reacttraining.com/react-router/web/guides/quick-start)
 *
 * @author [Christoph Kunz](https://github.com/christophkunz)
 */
class App extends React.Component {

    #firebaseConfig = {
        apiKey: "AIzaSyDYY1X2Mtxg5xeSHsuFWNK8vuw_qwAfgM4",
        authDomain: "bankbeispiel-426c2.firebaseapp.com",
        projectId: "bankbeispiel-426c2",
        storageBucket: "bankbeispiel-426c2.appspot.com",
        messagingSenderId: "54183409381",
        appId: "1:54183409381:web:b21f7ca930084dccfb860c"
    };

	/** Constructor of the app, which initializes firebase  */
	constructor(props) {
		super(props);

		// Init an empty state
		this.state = {
			currentUser: null,
			appError: null,
			authError: null,
			authLoading: false
		};
	}

	/** 
	 * Create an error boundary for this app and recieve all errors from below the component tree.
	 * 
	 * @See See Reacts [Error Boundaries](https://reactjs.org/docs/error-boundaries.html)
 	 */
	static getDerivedStateFromError(error) {
		// Update state so the next render will show the fallback UI.
		return { appError: error };
	}

	/** Handles firebase users logged in state changes  */
	handleAuthStateChange = user => {
		if (user) {
			this.setState({
				authLoading: true
			});
			// The user is signed in
			user.getIdToken().then(token => {
				// Add the token to the browser's cookies. The server will then be
				// able to verify the token against the API.
				// SECURITY NOTE: As cookies can easily be modified, only put the
				// token (which is verified server-side) in a cookie; do not add other
				// user information.
				document.cookie = `token=${token};path=/`;

				// Set the user not before the token arrived 
				this.setState({
					currentUser: user,
					authError: null,
					authLoading: false
				});
			}).catch(e => {
				this.setState({
					authError: e,
					authLoading: false
				});
			});
		} else {
			// User has logged out, so clear the id token
			document.cookie = 'token=;path=/';

			// Set the logged out user to null
			this.setState({
				currentUser: null,
				authLoading: false
			});
		}
	}

  /** 
   * Handles the sign in request of the SignIn component uses the firebase.auth() component to sign in.
	 * @see See Google [firebase.auth()](https://firebase.google.com/docs/reference/js/firebase.auth.Auth)
	 * @see See Google [firebase.auth().signInWithRedirect](https://firebase.google.com/docs/reference/js/firebase.auth.Auth#signinwithredirect)
	 */
	handleSignIn = () => {
		this.setState({
			authLoading: true
		});
		const provider = new firebase.auth.GoogleAuthProvider();
		firebase.auth().signInWithRedirect(provider);
	}

	/**
	 * Lifecycle method, which is called when the component gets inserted into the browsers DOM.
	 * Initializes the firebase SDK.
	 * 
	 * @see See Googles [firebase init process](https://firebase.google.com/docs/web/setup)
	 */
	componentDidMount() {
		firebase.initializeApp(this.#firebaseConfig);
		firebase.auth().languageCode = 'en';
		firebase.auth().onAuthStateChanged(this.handleAuthStateChange);
	}

	/** Renders the whole app */
	render() {
		const { currentUser, appError, authError, authLoading } = this.state;
		return (
          <Router basename={process.env.PUBLIC_URL}>
					<Container maxWidth='md'>
						{
							// Is a user signed in?
							currentUser ?
								<>
									<Start></Start>
								</>
								:
								// else show the sign in page
								<>
									<SignIn onSignIn={this.handleSignIn} />
								</>
						}
					</Container>
				</Router>
		);
	}
}

export default App;