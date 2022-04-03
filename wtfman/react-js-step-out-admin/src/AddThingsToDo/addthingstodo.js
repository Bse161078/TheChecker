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
import MenuItem from '@mui/material/MenuItem';
import Header from '../Header/header'
function Addthingstodo(props) {
    const [openAlert,setOpenAlert] = useState(false)
    const [message,setMessage] = useState(false)
    const [restaurant,setRestaurant] = useState()
    const handleClose=()=>{
        setOpenAlert(false)
    }
    const restaurants = [
        {
          value: 'Fine Dining.',
          type:1
        },
        {
          value: 'Fast Food',
          type:2
        },
        {
          value: 'Cafe',
          type:3
        },
        {
          value: 'Buffet',
          type:4
        },
      ];
  return (
    <Box >
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
                     Add Things To Do.
                    </Typography>
                    <Box textAlign='center' sx={{marginTop:2}}>
                    <Typography variant = 'caption'> 
                    Please enter below details to add things.
                    </Typography>
                    </Box>
                    <Box component="form"  >
                        <Grid container direction='row' spacing={3} sx={{mt:2,mb:2}} >
                        <Grid item xs={3.5} md ={3.5}>
                            <Grid container direction="row" justify="center"></Grid>
                        </Grid>
                        <Grid item xs={2} md ={2}>
                             <TextField  label="Address" type="text" variant="outlined" 
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
                        <Grid item xs={3.5} md ={3.5}>
                            <Grid container direction="row" justify="center"></Grid>
                        </Grid>
                        <Grid item xs={2} md ={2}>
                             <TextField  label="Opening time" type="datetime-local" variant="outlined" 
                             InputLabelProps={{
                                shrink: true,
                              }}
                             className="inputRounded"fullWidth/>
                        </Grid>
                        <Grid item xs={1} md ={1}>
                            <Grid container direction="row" justify="center"></Grid>
                        </Grid>
                        <Grid item xs={2} md ={2}>
                             <TextField label="Closing time" type="datetime-local" variant="outlined" 
                             InputLabelProps={{
                                shrink: true,
                              }}
                              className="inputRounded"/>
                        </Grid>
                        <Grid item xs={3.5}md ={3.5}>
                            <Grid container direction="row" justify="center"></Grid>
                        </Grid>
                        <Grid item xs={3.5} md ={3.5}>
                            <Grid container direction="row" justify="center"></Grid>
                        </Grid>
                        <Grid item xs={2} md ={2}>
                             <TextField  label="Name" type="text" variant="outlined" 
                             className="inputRounded"fullWidth/>
                        </Grid>
                        <Grid item xs={1} md ={1}>
                            <Grid container direction="row" justify="center"></Grid>
                        </Grid>
                        <Grid item xs={2} md ={2}>
                             <TextField label="Type of restaurant" select 
                              className="inputRounded" helperText="Please select restaurant type"
                               value = {restaurant} onChange={(e)=>{
                                    setRestaurant(e.target.value)
                               }}fullWidth>
                                   {restaurants.map((option) => (
                                    <MenuItem key={option.value} value={option.value}>
                               <Stack direction="column" spacing={2}> {option.value} </Stack>
                                    </MenuItem>
                                       ))}
                               </TextField>
                        </Grid>
                        <Grid item xs={3.5}md ={3.5}>
                            <Grid container direction="row" justify="center"></Grid>
                        </Grid>
                        <Grid item xs={3.5} md ={3.5}>
                            <Grid container direction="row" justify="center"></Grid>
                        </Grid>
                        <Grid item xs={2} md ={2}>
                             <TextField  label="Location" type="text" variant="outlined" 
                             className="inputRounded"fullWidth/>
                        </Grid>
                        <Grid item xs={1} md ={1}>
                            <Grid container direction="row" justify="center"></Grid>
                        </Grid>
                        <Grid item xs={2} md ={2}>
                              <TextField label="Add Tags" select 
                              className="inputRounded" helperText="Please select tags"
                               value = {restaurant} onChange={(e)=>{
                                    setRestaurant(e.target.value)
                               }}
                               fullWidth>
                                   {restaurants.map((option) => (
                                    <MenuItem key={option.value} value={option.value}>
                                    {option.value}
                                    </MenuItem>
                                       ))}
                                       </TextField>
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
                            Save
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

export default Addthingstodo