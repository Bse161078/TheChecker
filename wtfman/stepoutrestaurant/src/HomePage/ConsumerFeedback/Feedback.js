import React from 'react'
import Torilla from '../../Public/Torilla.svg'
import Box from '@mui/material/Box';
import Paper from '@mui/material/Paper';
import { Typography } from '@mui/material';
import { Grid } from '@mui/material';
function Feedback() {
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
        width: "100%",
        marginTop:20,
        background:'black',
    },


    }}
  >
    <Paper elevation={0} >
        <Grid container md={12} sx={{padding:0}} >
            <Grid md={1}></Grid>
        <Grid md={2} sx={{marginTop:10}}   >
        <img src={Torilla} sx={{ display:'flex' ,alignContent:'left',width:'100%',height:'100%'}}/>
        </Grid>
        <Grid md={1}></Grid>

        <Grid md={3} sx={{marginTop:10}} >
        <Typography variant='h4' style={{color:'white'}} >"Stepout are awesome to work with. They’re super supportive and always suggest new ideas to grow our sales"</Typography>
        </Grid>
        <Grid md={1}></Grid>
        <Grid md={4} sx={{position:"-webkit-sticky",paddingBottom:'10px'}}  >
            <img src="https://images.prismic.io/deliveroo-restaurants/11cc68c7-fa67-495d-a0de-500fbcd8f743_Rx-phone-GB.png?auto=compress,format" style={{width:'60%',height:'100%'}} />
        </Grid>

        </Grid>
   </Paper>
  </Box>
    </div>
  )
}

export default Feedback