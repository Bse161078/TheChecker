import React from 'react'
import Box from '@mui/material/Box';
import Paper from '@mui/material/Paper';
import map from '../../Public/map.svg'
import { Typography } from '@mui/material';
import { Grid } from '@mui/material';
function DeliveryDetails() {
  return (
    <div>       
 <Box
    sx={{
      display: 'flex',
      flexWrap: 'wrap',
      justifyContent:'center',
      
      '& > :not(style)': {
        m: 1,
        width: "70vw",
        marginTop:20,
        padding:5
       
      },
    }}
  >
    <Paper elevation={12} >
        <Typography variant="h3"style={{fontWeight:'bold'}}>
        We're here to deliver
        </Typography>
        <Grid container direction='row' spacing={1} >
            <Grid item md={4}>
        <img src={map} style={{width:'50%',height:'50%'}}/>
        <Typography variant="h2" style={{fontWeight:'bold'}} >14000+</Typography>
        <Typography variant="h5" style={{fontWeight:'bold'}}>Restaurant partners globally</Typography>
        </Grid>
        <Grid item md={4}>
        <img src="https://deliveroo-restaurants.cdn.prismic.io/deliveroo-restaurants/2197a22f-fcd2-4f88-ae85-de118ab17ca2_food+icon+plus.svg" style={{width:'50%',height:'50%'}} />
        <Typography variant="h2" style={{fontWeight:'bold'}} >364000+</Typography>
        <Typography variant="h5" style={{fontWeight:'bold'}}>Restaurant partners globally</Typography>
        </Grid>
        <Grid item md={4}>
        <img src='https://deliveroo-restaurants.cdn.prismic.io/deliveroo-restaurants/cef16ec1-4cb4-4f83-bdaf-67483fa76da4_kelp+lightning+icon.svg' style={{width:'50%',height:'50%'}}/>
        <Typography variant="h2" style={{fontWeight:'bold'}} >1000+</Typography>
        <Typography variant="h5" style={{fontWeight:'bold',}}>Restaurant partners globally</Typography>
        </Grid>
        </Grid>
   </Paper>
  </Box>
  </div>
  )
}

export default DeliveryDetails