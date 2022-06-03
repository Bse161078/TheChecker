import React,{useState} from 'react'
import Box from '@mui/material/Box';
import Paper from '@mui/material/Paper';
import { Typography } from '@mui/material';
import { Button } from '@mui/material';
import { Grid } from '@mui/material';
import Radio from '@mui/material/Radio';
import '../../App.css'
import AlertMessages from '../../AlertMessages/AlertMessages';
function Index(props) {
    const [radioB,setRadioB] = useState(false)
    const [open,setOpen] = useState(false)
    const [message,setMessage] = useState()
    const [messageType,setMessageType] = useState()
      const handleRadioB=()=>{
       setRadioB("success")
    }
    const {setShowSignup,setShowConditions} = props
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
        <Grid container >
        <Grid md ={2}></Grid>
                <Grid md={8} sx={{padding:2}} >
                    <Typography variant="h4" sx={{color:'black'}} >
                        Terms And Conditions
                    </Typography>
                </Grid>
                <Grid md ={2}></Grid>
            <Grid container direction="column" md ={1}>
                
                <Grid md={6}></Grid>
                <Grid md={2}>
                <Radio color="success" value='success' onClick={handleRadioB}/>
                </Grid>
            </Grid>
            <Grid md={11}>   
          <Typography variant='body1' align="left" sx={{color:'black'}} >
            Welcome to Website Name!

            These terms and conditions outline the rules and regulations for the use of Company Name's Website, located at Website.com.

            By accessing this website we assume you accept these terms and conditions. Do not continue to use Website Name if you do not agree to take all of the terms and conditions stated on this page.

            The following terminology applies to these Terms and Conditions, Privacy Statement and Disclaimer Notice and all Agreements: “Client”, “You” and “Your” refers to you, the person log on this website and compliant to the Company's terms and conditions. “The Company”, “Ourselves”, “We”, “Our” and “Us”, refers to our Company. “Party”, “Parties”, or “Us”, refers to both the Client and ourselves. All terms refer to the offer, acceptance and consideration of payment necessary to undertake the process of our assistance to the Client in the most appropriate manner for the express purpose of meeting the Client's needs in respect of provision of the Company's stated services, in accordance with and subject to, prevailing law of Netherlands. Any use of the above terminology or other words in the singular, plural, capitalization and/or he/she or they, are taken as interchangeable and therefore as referring to same.
          </Typography>
          </Grid>
          <Grid md ={3}></Grid>
            <Grid md={2}sx={{padding:3}}>
            <Button variant = 'contained'
            color="warning"
            fullWidth
            onClick={()=>setShowConditions(false)}
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

                if(radioB!=="success")
                { 
                    setMessage("Please Select Terms and Conditions to Continue")
                    setMessageType("error")
                    setOpen(true)
                       

            
                }else{
                    setShowSignup(true)
                    setOpen(true)
                    setShowConditions(false)
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

export default Index