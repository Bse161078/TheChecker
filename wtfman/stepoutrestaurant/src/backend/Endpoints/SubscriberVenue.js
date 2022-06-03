import React from 'react'
import {db} from '../FirebaseConnection/firebase';
import {Subscriber} from '../Modal/Subscriber'
export const addSubscriber = async function (data) {
    console.log("venueobj",data)
    await db
      .collection("SignupSubscriber")
      .add(data)
      .then(async function (docRef) {
          data.id = docRef.id;
          await updateSubs(docRef.id, data);
      })
  };
  export const updateSubs = async function (id, data) {
 await db.collection("SignupSubscriber").doc(id).set(data, { merge: true });
};
export const checkSubscriber = async function (email) {
    const query = await db.collection("SignupSubscriber").get();
    let SubscriberSignup = [];
   query.docs.forEach((doc) => {
     const user = Subscriber.fromFirestore(doc);
     if (user) 
     {
        SubscriberSignup.push(user);
     }
   });
   console.log("Users", SubscriberSignup,email);
   const val =SubscriberSignup.filter((sub)=>sub.email===email)
   if(val.length>0)
   return true
   else
   return false
   console.log('val',val)

}

