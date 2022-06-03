import React, {useState} from 'react'
import Tabs from '@mui/material/Tabs';
import Tab from '@mui/material/Tab';
import Box from '@mui/material/Box';
import Logo from '../../Public/logo.png'
import KeyboardArrowDownIcon from '@mui/icons-material/KeyboardArrowDown';
import Button from '@mui/material/Button';
function MainNavbar() {
    const [value,setValue] = useState()
    const handleChange={
         }
  return (
    <div>
    <Box sx={{padding:4 }}>
    <Tabs
      onChange={handleChange}
      value={value}
    >
        <img src={Logo} style={{background:'transparent',width:50,height:50}}/>
      <Tab label="StepoutSubscribe" sx={{color:"white" }} >
          
      </Tab>
      <Tab label="Get Started" sx={{color:"white",marginLeft:40,padding:0 }} >
        </Tab>
        <KeyboardArrowDownIcon sx={{color:"white",marginTop:1.5,borderRadius:10}} />
        <Tab label="Services" sx={{color:"white",marginLeft:2,padding:0 }} >
        </Tab>
        <KeyboardArrowDownIcon sx={{color:"white",marginTop:1.5,borderRadius:10}} />
        <Tab label="Support" sx={{color:"white",marginLeft:2,padding:0 }} >
        </Tab>
        <KeyboardArrowDownIcon sx={{color:"white",marginTop:1.5,borderRadius:10}} />
        <Button variant="outlined" sx={{marginLeft:2,color:'white',borderRadius:10,
        marginTop:1,marginBottom:1,borderColor:'black',fontSize:15}} >Login</Button>
        <Button variant="outlined" sx={{marginLeft:2,color:'white',
        borderRadius:10,marginTop:1,marginBottom:1,borderColor:'black',fontSize:15}} >Become A partner</Button>
        
    </Tabs>
    
    </Box> 
     </div>
  )
}

export default MainNavbar