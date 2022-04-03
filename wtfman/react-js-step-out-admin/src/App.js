import './App.css';
import { useState } from 'react';
import Grid from '@mui/material/Grid';
import Box from '@mui/material/Box';
import Logo from './Assets/Logo.png'
import LogoImage from './Assets/Logoimage.png'
import Homepage from './Homepage/homepage'
import SignUp from './CreateAccount/signup';
import Login from './Login/login';
import Addthingstodo from './AddThingsToDo/addthingstodo';
import AddBlogs from './AddBlogs/addBlogs';
import AddTrips from './AddTrips/addTrips';
function App() {
  const [openRegister,setOpenRegister] = useState(false)
  const [openLogin,setOpenLogin] = useState(false)
  const [homepage,setHomepage] = useState(true)
  const [openAddThings,setOpenAddThings] = useState(false)
  const [openBlogs,setOpenBlogs] =useState(false)
  const [openTrips,setOpenTrips] =useState(true)
  const [openDrawer,setOpenDrawer] =useState(false)
    console.log('openTrips',openTrips)
 return (
<Box sx={{ flexGrow: 1,background:'#0AC2CC'}}>
      <Grid container>
        <Grid item xs={5.7} md ={5.7}>
        <Grid container direction="row" justify="center"></Grid>
        </Grid>
        <Grid item xs={5} md ={5}>
         
              <img src={Logo}/>
                </Grid>
        <Grid item xs={5} md ={5}>
        <Grid container direction="row" justify="center"></Grid>
        </Grid>
        <Grid xs={5} md={5}>
        <img src={homepage&&LogoImage}/>
        </Grid>
        <Grid item xs={3} md ={3}>
        <Grid container direction="row" justify="center"></Grid>
        </Grid>
        <Grid xs={12} md={12}>
          {homepage?<Homepage  setOpenRegister={setOpenRegister} setOpenLogin={setOpenLogin}
           setHomepage={setHomepage} />
          : openRegister?<SignUp setOpenLogin={setOpenLogin} setOpenRegister={setOpenRegister} 
          setHomepage={setHomepage} setOpenAddThings={setOpenAddThings}/>
          :openLogin?<Login setOpenLogin={setOpenLogin} setOpenRegister={setOpenRegister} 
           setHomepage={setHomepage} setOpenAddThings={setOpenAddThings}/>
           :openAddThings?<Addthingstodo setOpenBlogs={setOpenBlogs}  setOpenTrips={setOpenTrips}
           setOpenAddThings={setOpenAddThings} setOpenDrawer={setOpenDrawer} openDrawer={openDrawer} />
           :openBlogs?<AddBlogs
           setOpenBlogs={setOpenBlogs} setOpenAddThings={setOpenAddThings}
            setOpenDrawer={setOpenDrawer} openDrawer={openDrawer} setOpenTrips={setOpenTrips} />
          :openTrips&&<AddTrips
          setOpenBlogs={setOpenBlogs} setOpenAddThings={setOpenAddThings}
            setOpenDrawer={setOpenDrawer} openDrawer={openDrawer} setOpenTrips={setOpenTrips}
          />
          }
        </Grid>
      </Grid>
</Box>
  );
}

export default App;
