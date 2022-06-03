import React,{useState,useEffect} from 'react'
import Box from '@mui/material/Box';
import Paper from '@mui/material/Paper';
import '../../App.css'
import {Form, Formik} from "formik";
import AlertMessages from '../../AlertMessages/AlertMessages';
import axios from 'axios'
import {Elements} from "@stripe/react-stripe-js";
import {loadStripe} from "@stripe/stripe-js";
import AddCard from '../../backend/Endpoints/Stripe/AddCard';

const stripePromise = loadStripe(
  "pk_live_51L5Yc7Jngle5KEdgQl2hATMa7uIYi6ZLQFuTsl0nTAbR7vfUlpvEtEbUXTbpOAquJSmjg0SBPiJO9C6xqfqYKtEN00fcpnLlOc");
function Index(props) {
  const {open,message,messageType,setOpen,stripeId,subscribtion} = props
  const [clientSecret,setClientSecret] = useState()
  console.log('stripeid',stripeId)
   useEffect(()=>{
    console.log('addcard = ',stripeId)
    addUser()
   },[])
  
   const addUser = async()=>{
    const url = "https://stripe-subscription-api.herokuapp.com/add-card-intent"
    const body = {stripe_id:stripeId} 
    try{
        const response =  await axios.post(url,body);
        console.log("responseaddcard = ",response);
        setClientSecret(response.data.clientSecret)
    }catch(err){
        console.log("err = ",err);
    }
  }
  const appearance = {
    theme: 'night',
};
const options = {
    clientSecret,
    appearance
  };
  console.log("subscribtion",subscribtion)
  return (
    <div>
       {open&&<AlertMessages message={message} messageType={messageType} open={open} setOpen={setOpen}/> }
         <Box
      sx={{
        display: 'flex',
        flexWrap: 'wrap',
        
        '& > :not(style)': {
          m: 1,
          width: '50%',
          height:'100vh',
          padding:'20px',
          background:'whitesmoke',
          position:'absolute',
          borderRadius:10 ,
          borderColor:'white'
        },
        marginTop:10
      }}
    >
      <Paper elevation={3}  >
    {clientSecret && (
      <Elements style={{width:'100%'}}  options={options} stripe={stripePromise}>
          <AddCard clientSecret={clientSecret} subscribtion={subscribtion}/>
      </Elements>
             )}
      </Paper>
    </Box>
    </div>
  )
}

export default Index;