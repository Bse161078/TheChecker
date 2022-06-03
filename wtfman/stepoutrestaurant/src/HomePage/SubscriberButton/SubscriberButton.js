import React,{useState} from 'react'
import Button from '@mui/material/Button';
import DeliveryDetails from '../DeliveryDetails/DeliveryDetails';
import BuisnessCard from '../HelpYourBuisness/BuisnessCard';
import Feedback from '../ConsumerFeedback/Feedback';
import Index from '../HowItWorks/Index';
import NotAPartner from '../NotAPartner/Index';
import TermsAndConditions from '../TermsAndConditions/Index';
import { Grid } from '@mui/material';
import StripeElement from '../Stripe/Index';
import SignupModal from '../../SubscriberSignup/SignupModal';
import AlertMessages from '../../AlertMessages/AlertMessages';

function SubscriberButton () {
const [radioB,setRadioB] = useState(false)
const [open,setOpen] = useState(false)
const [message,setMessage] = useState()
const [stripeId,setStripeId] = useState() 
const [messageType,setMessageType] = useState()
const [showCoditions,setShowConditions] =useState(false)
const [showStripeElement,setShowStripeElement] =useState(false)
const [showSignup,setShowSignup] =useState(false)
const [subscribtion,setSubscribtion] = useState()
console.log('stripeid',stripeId)
    return (
    <div style={{  
        backgroundImage: "url(" + "https://images.prismic.io/deliveroo-restaurants/8162ba05-7f3e-431a-bbea-53916ee3f77f_zabardast_04-comp2.jpg?auto=compress,format" + ")",
        backgroundPosition: 'center',
        backgroundSize: 'cover',
        position:"absolute",
        width:'100%',
        height:'100%'
      }} >
          {open&&<AlertMessages message={message} messageType={messageType} open={open} setOpen={setOpen}/> }
          <Grid container justify = "center">
              <Grid md={3}></Grid>
            <Grid md ={4}>
        {showStripeElement&&<StripeElement subscribtion={subscribtion} setMessage={setMessage} setMessageType={setMessageType} setOpen={setOpen}  setShowStripeElement={setShowStripeElement} stripeId={stripeId} />}
        {showSignup&&<SignupModal setMessage={setMessage} setMessageType={setMessageType} setOpen={setOpen}  setShowSignup={setShowSignup} setShowStripeElement={setShowStripeElement} setStripeId={setStripeId} setSubscribtion={setSubscribtion}  />}
        {showCoditions&&<TermsAndConditions setShowConditions={setShowConditions} setShowSignup={setShowSignup} />}
        </Grid>
        </Grid>
        <h1 style={{color:'white',marginTop:'40vh',fontSize:'50px'}} >Become a Partner with Stepout</h1>
        <h2 style={{color:'white',fontSize:'30px',fontStyle:"oblique"}} >Together we can keep your kitchen busier than ever</h2>
        {!showCoditions&&!showSignup&&!showStripeElement&&<Button variant="contained" style={{fontSize:40,width:'50vw',background:"#BE0101",color:'whitesmoke',fontWeight:'bolder',borderRadius:40}}onClick={()=>{
            setShowConditions(true)
        }}  >Subscribe</Button>}
        <DeliveryDetails/>
        <BuisnessCard/>
        <Feedback/>
        <Index/>
        <NotAPartner />
        
    </div>
  )
}

export default SubscriberButton