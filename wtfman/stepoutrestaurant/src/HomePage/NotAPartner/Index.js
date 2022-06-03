import React from 'react'
import Box from '@mui/material/Box';
import Paper from '@mui/material/Paper';
import { Typography } from '@mui/material';
import { Grid } from '@mui/material';
import { Button } from '@mui/material';
function Index() {
  return (
    <div> 
       <Box
    sx={{
      display: 'flex',
      flexWrap: 'wrap',
      justifyContent:'left',
      alignContent:'left',
      alignItem:'left',
      '& > :not(style)': {
        width: "80%",
        padding:5,
        ml:15,
        background:'black',
    },


    }}
  >
    <Paper elevation={0} >
        <Grid container md={12} sx={{padding:0}} >
            <Grid md={1}></Grid>
        <Grid md={6} sx={{marginTop:10}}   >
            <Typography variant ='h3' sx={{color:'white'}} >
                Not a Stepout Partner yet?
            </Typography>
        </Grid>
        <Grid md={1}></Grid>

        <Grid md={4}  sx={{marginTop:10}} >
            {/* <Button size='large' variant='outlined' sx={{fontSize:'25px',background:'#BE0101',color:'white'}}>
                Create Account
            </Button> */}
            <Button variant="contained" sx={{fontSize:25,background:"#BE0101",color:'whitesmoke',fontWeight:'bold'}}  >Create Account</Button>
        </Grid>
       

        </Grid>
   </Paper>
  </Box>
  </div>
  )
}

export default Index