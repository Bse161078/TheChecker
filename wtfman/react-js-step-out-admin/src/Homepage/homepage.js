import React from 'react'
import Box from '@mui/material/Box';
import Paper from '@mui/material/Paper';
import Grid from '@mui/material/Grid';
import { Typography } from '@mui/material';
import Button from '@mui/material/Button';
function homepage(props) {
  return (
    <div>
        <Box>
            <Grid container direction='column' spacing={37}>
            <Grid item xs={1} md ={1}>
        <Grid container direction="row" justify="center"></Grid>
        </Grid>
        <Grid item xs={12} md ={12}>
            <Paper variant="outlined">
           <Typography variant = 'h5' align="center" sx={{marginTop:1}} > 
               How would you like to proceed?
            </Typography>
            <Box textAlign='center' sx={{marginTop:2}}>
                <Button variant='contained' size='large' 
                style={{width:315,height:39,border:'1px solid #0AC2CC',borderRadius:20,background:'#0AC2CC',color:'white'}}
                onClick={()=>{
                    props.setHomepage(false)
                    props.setOpenRegister(true)
                }}
                >
                    Register
                </Button>
            </Box>
            <Box textAlign='center' sx={{marginTop:5,marginBottom:2}}>
                <Button variant='contained' size='large' 
                style={{width:315,height:39,border:'1px solid #0AC2CC',borderRadius:20,color:'#0AC2CC',background:'white'}} 
                onClick={()=>{
                    props.setHomepage(false)
                    props.setOpenLogin(true)
                }}
                >
                    Login
                </Button>
            </Box>
            </Paper>
            </Grid>
            </Grid>
        </Box>
    </div>
  )
}

export default homepage