import React from 'react'
import { Grid } from '@mui/material'
import { Typography } from '@mui/material'
import '../../index.css'
function Index() {
  return (
        <Grid container md={12} sx={{marginTop:5}} >
            <Grid item md={12}>
                <Typography variant='h2' align='center' sx={{fontWeight:'bold'}} >
                    How does Stepout work?
                </Typography>
            </Grid>
            <Grid item md={12} sx={{marginTop:2}} >
                <Typography variant='h5' align='center'>
                Fire up your kitchen for Deliveroo orders in a few easy steps
                </Typography>
            </Grid>
            <Grid item md={1}></Grid>
            <Grid item md={5} sx={{marginTop:3}} >
                <img src="https://images.prismic.io/deliveroo-restaurants/19dff330-c41b-4916-87dd-3077c044b15b_restaurant_Deliveroo_Shot_23_2226_LR.jpg?auto=compress,format"  style={{borderRadius:15,height:'70%',width:'100%'}} />
            </Grid>
            <Grid item md={1}></Grid>
            <Grid item md={5} >
                <div class="a-checkpoint-list">
            <ul >
                <li >
                    <Typography variant="h4" align='left' sx={{fontWeight:'bold'}}>Signup</Typography>
                    <Typography variant='h6' align='left'>Tell us about your business - you'll need your FSA rating to get started</Typography>
                </li>
                <li style={{marginTop:20}}>
                    <Typography variant="h4" align='left' sx={{fontWeight:'bold'}}>Set up</Typography>
                    <Typography variant='h6' align='left'>Upload a menu and share your store hours</Typography>
                </li>
                <li style={{marginTop:20}}>
                    <Typography variant="h4" align='left' sx={{fontWeight:'bold'}}>Sell</Typography>
                    <Typography variant='h6' align='left'>Watch the orders come in and track them via Restaurant Hub</Typography>
                </li>
                </ul>
                </div>
            </Grid>
        </Grid>
  )
}

export default Index