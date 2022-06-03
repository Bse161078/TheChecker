import React from 'react'
import { Typography } from '@mui/material'
import { Grid } from '@mui/material'
import ArrowRightAltIcon from '@mui/icons-material/ArrowRightAlt';
function BuisnessCard() {
  return (
    <div>
        <Typography variant="h2" style={{marginTop:'50px',fontWeight:'bold'}} >
        How we can help your business
        </Typography>
        <Grid container md={12}  >
            <Grid item md={0.3}></Grid>
            <Grid item md={7} style={{marginTop:'7vh'}}  >
                <img src="https://images.prismic.io/deliveroo-restaurants/a8ecbdcd-ea07-4a44-ad97-bf2ede5bd508_Deliveroo_Groceries_Bilboard_EN-comp.jpg?auto=compress,format" style={{borderRadius:20,width:'80%',height:'80%'}} />
            </Grid>
            <Grid item md={4} style={{marginTop:"18vh"}} >
                <Typography variant="h4" align="left" style={{fontWeight:'bold'}} >
                Promote your business
                </Typography>
                <Typography variant='h5' align="left" style={{marginTop:20}} >Boost sales by increasing your visibility on the  most popular online channels.</Typography>
                <Typography variant="h6" align="left" sx={{color:'#BE0101',marginTop:5}} >
                    Find out more about marketing
                    <ArrowRightAltIcon  />
                </Typography>

            </Grid>
            <Grid md ={0.3}></Grid>
        </Grid>
        <Grid container md={12}  >
            <Grid item md={1}></Grid>
            <Grid item md={4} style={{marginTop:"18vh"}} >
                <Typography variant="h4" align="left" style={{fontWeight:'bold'}} >
                Reach more customers
                </Typography>
                <Typography variant='h5' align="left" style={{marginTop:20}} >Attract new customers and keep them coming back for more with the delivery type that works for you.</Typography>
                <Typography variant="h6" align="left" sx={{color:'#BE0101',marginTop:5}} >
                    Find out more about your delivery services
                    <ArrowRightAltIcon  />
                </Typography>

            </Grid>
            <Grid item md={7} style={{marginTop:'7vh'}}  >
                <img src="https://images.prismic.io/deliveroo-restaurants/5f3241f5-2540-4d68-a42e-5f16964c9761_restaurant_about_gb_2.jpg?auto=compress,format" style={{borderRadius:20,width:'80%',height:'80%'}} />
            </Grid>
        </Grid>
        <Grid container md={12}  >
        <Grid item md={0.2}></Grid>

            <Grid item md={7} style={{marginTop:'7vh'}}  >
                <img src="https://images.prismic.io/deliveroo-restaurants/11e9ac63-fccb-44b0-91a4-cc3061d47c59_Restaurant-chef.jpg?auto=compress,format" style={{borderRadius:20,width:'80%',height:'80%'}} />
            </Grid>
            <Grid item md={4} style={{marginTop:"18vh"}} >
                <Typography variant="h4" align="left" style={{fontWeight:'bold'}} >
                Reach more customers
                </Typography>
                <Typography variant='h5' align="left" style={{marginTop:20}} >Attract new customers and keep them coming back for more with the delivery type that works for you.</Typography>
                <Typography variant="h6" align="left" sx={{color:'#BE0101',marginTop:5}} >
                    Find out more about your delivery services
                    <ArrowRightAltIcon  />
                </Typography>

            </Grid>
            <Grid md ={0.10}></Grid>

        </Grid>
    </div>
  )
}

export default BuisnessCard