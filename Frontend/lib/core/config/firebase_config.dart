// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyAGPIvZvdbyrXwRJonYmSZvUHhGEmapec8",
  authDomain: "forexcompanion-e5a28.firebaseapp.com",
  databaseURL: "https://forexcompanion-e5a28-default-rtdb.firebaseio.com",
  projectId: "forexcompanion-e5a28",
  storageBucket: "forexcompanion-e5a28.firebasestorage.app",
  messagingSenderId: "238745148522",
  appId: "1:238745148522:web:91d07c07f4edf09026be13",
  measurementId: "G-F24QVTGL77"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);