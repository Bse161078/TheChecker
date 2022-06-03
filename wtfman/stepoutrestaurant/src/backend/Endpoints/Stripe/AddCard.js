import React,{Fragment,useState,useEffect} from 'react'
import ReactDOM from 'react-dom';
import {loadStripe} from '@stripe/stripe-js';
import {
  CardElement,
  useStripe,
  useElements,
} from '@stripe/react-stripe-js';
import {PaymentElement} from '@stripe/react-stripe-js';
import { Button,Typography,Grid } from '@mui/material';
import axios from 'axios';

function AddCard(props) {
  const {subscribtion,clientSecret} = props
  const stripe = useStripe();
  const elements = useElements();
  const [setupIntent,setSetupIntent] = useState()
  const [isLoading,setIsLoading] = useState(false)
  const [isCardAdded,setIsCardAdded] = useState(false)
//   const handleSubmit = async (event) => {
//     event.preventDefault();

//     if (elements == null) {
//       return;
//     }

//     const {error, paymentMethod} = await stripe.createPaymentMethod({
//       type: 'card',
//       card: elements.getElement(CardElement),
//     });
//   };
     const addUser = async()=>{
    const url = "https://stripe-subscription-api.herokuapp.com/add-card-intent"
    const body = {stripe_id:"stripeId"} 
    try{
        const response =  await axios.post(url,body);
        console.log("response = ",response);
        
    }catch(err){
        console.log("err = ",err);
    }
   
}
const createSubscription = (paymentMethod) => {
    setIsLoading(true)
    console.log('paymentMethod',paymentMethod)
      const body ={
          user_id:subscribtion.id,
          paymentMethod:paymentMethod,
          subscriptionName:"StepoutSubscribtion"
      }
    axios.post('https://stripe-subscription-api.herokuapp.com/create-stripe-subscription', {
        body
    }).then((response) => {
        console.log("subscription = ", response);
        setIsLoading(false);

        const user = response.data.user;
        const token = response.data.tokens;
      
    }).catch((err) => {
        console.log("err = ", err.response)
        setIsLoading(false)
    })
}

useEffect(() => {
    setIsLoading(true)
    
    if (!stripe) {
        return;
    }

    const clientSecret = new URLSearchParams(window.location.search).get(
        "setup_intent_client_secret"
    );
    if (!clientSecret) {
        return;
    }

    stripe.retrieveSetupIntent(clientSecret).then(({setupIntent}) => {
        console.log("setupIntent111 = ",setupIntent)
       setSetupIntent(setupIntent.payment_method)
        switch (setupIntent.status) {
            case "succeeded":
                setIsCardAdded({status: true, msg: "Success! Your payment method has been saved!"});
                createSubscription(setupIntent.payment_method);
                setIsLoading(false)
                localStorage.setItem("status",setupIntent.status)
                break;
            case "processing":
                setIsCardAdded({
                    status: false,
                    msg: "Processing payment details. We'll update you when processing is complete!",
                });
                setIsLoading(false)
                break;
            case 'requires_payment_method':
                setIsCardAdded({
                    status: false,
                    msg: "Failed to process payment details. Please try another payment method!"
                })
                setIsLoading(false)
                break;
            default:
                setIsCardAdded({status: false, msg: "Something went wrong!"})
                setIsLoading(false)
                break;
        }
    });
}, [stripe]);
console.log('subscribtion',clientSecret)
useEffect(()=>{
    if(isCardAdded.status){
    }
},[isCardAdded])
const handleSubmit = async (event) => {
    console.log('handlesubmit',elements.getElement(CardElement))
    event.preventDefault();

    if (elements == null) {
      return;
    }

    stripe.retrieveSetupIntent(clientSecret).then(({setupIntent}) => {
        console.log('seteupintent',setupIntent)
        createSubscription(setupIntent.payment_method);
    })
    // const {error} = await stripe.confirmSetup({
    //     elements,
    //     confirmParams: {
    //         // Make sure to change this to your payment completion page
    //         return_url:"http://localhost:3002/"
    //     },
    // });
    //createSubscription();
  };
  return (
    <form onSubmit={handleSubmit}>
      <PaymentElement />
      <button type="submit" disabled={!stripe || !elements}>
        Pay
      </button>
    </form>
  );
};

export default AddCard