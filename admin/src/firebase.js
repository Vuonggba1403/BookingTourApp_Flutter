// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getFirestore } from "firebase/firestore";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries
// Your web app's Firebase configuration
const firebaseConfig = {
          apiKey: 'AIzaSyBVnAocxJDmkeb-l9N_r-Zhf29C7yc_u5c',
          authDomain: 'bookingtourapp-7ed7d.firebaseapp.com',
          projectId: 'bookingtourapp-7ed7d',
          storageBucket: 'bookingtourapp-7ed7d.appspot.com',
          messagingSenderId: '198466427601',
          appId: '1:198466427601:web:49b76d1378b01fc48e43f0',
          measurementId: 'G-MWZPSMF4MH',
        };
// Initialize Firebase

const app = initializeApp(firebaseConfig);
// Export firestore database
// It will be imported into your react app whenever it is needed
export const db = getFirestore(app);