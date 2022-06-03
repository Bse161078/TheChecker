import React,{useState} from 'react'
import Box from '@mui/material/Box';
import Paper from '@mui/material/Paper';
import { Typography } from '@mui/material';
import { Button } from '@mui/material';
import { Grid } from '@mui/material';
import TextField from '@mui/material/TextField';
import {addSubscriber,checkSubscriber} from '../backend/Endpoints/SubscriberVenue'
import { CreateUser } from '../backend/Endpoints/Stripe/CreateUser';
import axios from "axios";
import Loader from '../Loader/Loader';
function SignupModal(props) {
    const [email,setEmail] = useState(null)
    const [api,setApi] = useState(null)
    const [isLoading,setLoader] = useState(false)
    const {setMessage,setMessageType,setOpen,setShowSignup,setShowStripeElement,setStripeId,setSubscribtion}=props
    
    const addUser = async()=>{
    const url = "https://stripe-subscription-api.herokuapp.com/create-stripe-user"
    const body ={email:email}
    try{
        const response =  await axios.post(url,body);
        console.log("response = ",response.data.stripe_id);
        setStripeId(response.data.stripe_id)
        setSubscribtion(response.data)
        setMessage("Your Password will be emailed!")
        setMessageType("success")
        setOpen(true)
        setShowSignup(false)
        setShowStripeElement(true)
        setLoader(false)
    }catch(err){
        console.log("err = ",err);
        setMessage("Something wrong with stripe server!")
        setMessageType("error")
        setOpen(true)
        setShowSignup(false)
        setShowStripeElement(true)
        setLoader(false)
    }

    }

    const handleAddUser=async()=>{
        setLoader(true)
        const addSub = {
            email:email,
            api:api
        }
    try
    {
        const result = await checkSubscriber(email);
        console.log(result)
        if(result===true)
        {
        setLoader(false)
        setMessage("Your Email has already been Registered. Please Change Your Email!")
        setMessageType("info")
        setOpen(true)
        }
        else
        {
        addUser()
        
        }
    }
    catch(e)
    {
        setLoader(false)

        setMessage("Server is not Working! Sorry for inconvenience")
        setMessageType("error")
        setOpen(true)
        console.log("suberr",e)
    }
}
  return (
      <div>
    {isLoading&&<Loader/>}
    <Box
      sx={{
        display: 'flex',
        flexWrap: 'wrap',
        
        '& > :not(style)': {
          m: 1,
          width: '50%',
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
            <Grid container>
            <Grid md={12}>
            <Typography variant='h3' sx={{fontWeight:'bold'}}>
                SignUp
            </Typography>
            </Grid>
            <Grid md={2} sx={{marginTop:9}} >
            <Typography variant="body1" >
                    Email
                </Typography>
            </Grid>
            <Grid md={3} sx={{marginTop:7}}  >
                <TextField variant='outlined' label="Required" 
                onSelect={(e)=>{
                    setEmail(e.target.value)
                }}
                ></TextField>
            </Grid>
            <Grid md={2} sx={{marginTop:9}} >
            <Typography variant="body1" align="center"   >
                    Api Link
                </Typography>
            </Grid>
            <Grid md={3} sx={{marginTop:7}} >
                <TextField variant='outlined' label="Optional"  
                 onSelect={(e)=>{
                    setApi(e.target.value)
                }}
                ></TextField>
            </Grid>
            <Grid md ={3}></Grid>
            <Grid md={2}sx={{padding:3}}>
            <Button variant = 'contained'
            color="warning"
            fullWidth
            onClick={()=>{setShowSignup(false)}}
            >
                     Cancel
             </Button>
            </Grid>
            <Grid md={2}sx={{padding:3}}></Grid>
            <Grid  md ={2} sx={{padding:3}} >
            <Button variant = 'contained'
            color="success"
            fullWidth
            onClick={()=>{
                if(email===null)
                {
                    setMessage("Please enter the Email")
                    setMessageType("warning")
                    setOpen(true)
                }
                else
                {
                    handleAddUser()
                }
               
            }}

            >
                     Okay
             </Button>
             
            </Grid>
            </Grid>
            
        </Paper>
    </Box>
    </div>
  )
}

export default SignupModal