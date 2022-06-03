import React, {useState} from 'react'
import Grid from '@mui/material/Grid';
import MainNavbar from './MainNavbar/MainNavbar';
import SubscriberButton from './SubscriberButton/SubscriberButton';
function MainPage() {
   
  return (
      <div style={{width:'100vw',height:'100vh'}}>
    <Grid xs={12} sx={{display:{lg:'none',md:'none',xs:'block'},background:"red"}}  >
        asd
    </Grid>
    <Grid container direction="row"  md={12} sx={{display:{md:'block',xs:'none'},background:"black"}}>
    <Grid item md ={12} style={{background:"black"}} >
        <MainNavbar/>
    </Grid>
    <Grid item md={12}  style={{background:"black"}} >
        <SubscriberButton/>
    </Grid>
    

     </Grid>
    </div>
  )
}

export default MainPage