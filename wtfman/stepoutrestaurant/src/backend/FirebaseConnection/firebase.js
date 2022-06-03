import firebase from 'firebase/compat/app';
import 'firebase/compat/auth';
import 'firebase/compat/firestore';const config = {
  apiKey: "AIzaSyDAFQrPtUQuxIyfwvMWzZaq1kaqCvL4Ehk",
  authDomain: "react-native-step-out.firebaseapp.com",
  projectId: "react-native-step-out",
  databaseURL:"gs://react-native-step-out.appspot.com/",
  storageBucket: "react-native-step-out.appspot.com",
  messagingSenderId: "902770175125",
  appId: "1:902770175125:web:71aba1bf2c174f89bfbf9c",
  measurementId: "G-2ZP98N36GT"
};
firebase.initializeApp(config);
const db = firebase.firestore();
const auth = firebase.auth();

export { firebase, db, auth };
