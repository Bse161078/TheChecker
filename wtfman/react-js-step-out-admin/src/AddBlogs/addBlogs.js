import React from 'react'
import { useState } from 'react';
import Box from '@mui/material/Box';
import Paper from '@mui/material/Paper';
import Grid from '@mui/material/Grid';
import { Alert, Stack, Typography } from '@mui/material';
import Button from '@mui/material/Button';
import TextField from '@mui/material/TextField';
import "../index.css";
import Divider from '@mui/material/Divider';
import Snackbar from '@mui/material/Snackbar';
import Header from '../Header/header'
function AddBlogs(props) {
    const [openAlert,setOpenAlert] = useState(false)
    const [message,setMessage] = useState(false)
    const handleClose=()=>{
        setOpenAlert(false)
    }
  return (
    <Box>
        <Header setOpenDrawer={props.setOpenDrawer} openDrawer={props.openDrawer} 
        setOpenBlogs={props.setOpenBlogs} setOpenAddThings={props.setOpenAddThings}
        setOpenTrips={props.setOpenTrips}
         />

    <Snackbar
  open={openAlert}
  autoHideDuration={2000}
  onClose={handleClose}
  anchorOrigin={{
      vertical: "top",
      horizontal: "center"
    }}>
  <Alert open={openAlert} >{message}</Alert>   
   </Snackbar>
   <Grid container direction='column' spacing={5}>
      <Grid item xs={1} md ={1}>
          <Grid container direction="row" justify="center"></Grid>
      </Grid>
      <Grid item xs={12} md ={12}>
          <Paper variant="outlined">
              <Typography variant = 'h5' align="center" sx={{marginTop:2}} > 
               Add Blogs.
              </Typography>
              <Box textAlign='center' sx={{marginTop:2}}>
              <Typography variant = 'caption'> 
              Please enter below details to add blogs.
              </Typography>
              </Box>
              <Box component="form"  >
                  <Grid container direction='row' spacing={3} sx={{mt:2,mb:2}} >
                  <Grid item xs={3.5} md ={3.5}>
                      <Grid container direction="row" justify="center"></Grid>
                  </Grid>
                  <Grid item xs={2} md ={2}>
                       <TextField  label="Title" type="text" variant="outlined" 
                       className="inputRounded"fullWidth/>
                  </Grid>
                  <Grid item xs={1} md ={1}>
                      <Grid container direction="row" justify="center"></Grid>
                  </Grid>
                  <Grid item xs={2} md ={2}>
                       <TextField label="Description" type="text" variant="outlined" 
                        className="inputRounded"fullWidth/>
                  </Grid>
                  <Grid item xs={3.5}md ={3.5}>
                      <Grid container direction="row" justify="center"></Grid>
                  </Grid>
                  <Grid item xs={3.5} md ={3.5}>
                      <Grid container direction="row" justify="center"></Grid>
                  </Grid>
                  <Grid item xs={2} md ={2}>
                       <TextField  label="Display Image" type="file" variant="outlined" 
                       InputLabelProps={{
                          shrink: true,
                        }}
                       className="inputRounded"fullWidth/>
                  </Grid>
                  <Grid item xs={1} md ={1}>
                      <Grid container direction="row" justify="center"></Grid>
                  </Grid>
                  <Grid item xs={2} md ={2}>
                       <TextField label="Carousel Images" type="file" variant="outlined" 
                       InputLabelProps={{
                          shrink: true,
                        }}
                        className="inputRounded"fullWidth/>
                  </Grid>
                  <Grid item xs={3.5}md ={3.5}>
                      <Grid container direction="row" justify="center"></Grid>
                  </Grid>
                  <Grid item xs={4} md ={4}>
                      <Grid container direction="row" justify="center"></Grid>
                  </Grid>
                  <Grid item xs={4} md ={4} sx={{mt:2}}>
                      <Divider/>
                  </Grid>
                  <Grid item xs={4} md ={4}>
                      <Grid container direction="row" justify="center"></Grid>
                  </Grid>
                  <Grid item xs={4} md ={4}>
                      <Grid container direction="row" justify="center"></Grid>
                  </Grid> <Grid item xs={4} md ={4}>
                     
                  
                  <Box textAlign='center' sx={{marginTop:2}}>
                  <Button variant='contained' size='large' 
                  style={{width:315,height:39,border:'1px solid #0AC2CC',borderRadius:20,color:'#0AC2CC',background:'white'}}
                  onClick={()=>{
                      setOpenAlert(true)
                      setMessage("Saved Successfully")
                      }}
                  >
                      Add Blogs
                  </Button>
                 </Box>
                 </Grid>
                 <Grid item xs={4} md ={4}>
                      <Grid container direction="row" justify="center"></Grid>
                  </Grid>
                  <Grid item xs={4} md ={4}>
                      <Grid container direction="row" justify="center"></Grid>
                  </Grid> <Grid item xs={4} md ={4}>
                     
                  
                  <Box textAlign='center' sx={{marginTop:2,marginBottom:2}}>
                  <Button variant='contained' size='large' 
                  style={{width:315,height:39,border:'1px solid #0AC2CC',borderRadius:20,color:'#0AC2CC',background:'white'}}
                  type='reset'
                  onClick={()=>{
                      setOpenAlert(true)
                      setMessage("Reset Successfully")
                      }}
                 >
                      Reset
                  </Button>
                 </Box>
                 </Grid>
                 <Grid item xs={4} md ={4}>
                      <Grid container direction="row" justify="center"></Grid>
                  </Grid>
               </Grid>
              </Box>
          </Paper>
      </Grid>
   </Grid>
</Box>
  )
}

export default AddBlogs