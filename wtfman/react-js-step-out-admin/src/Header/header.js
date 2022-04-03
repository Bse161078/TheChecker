import React from 'react'
import AppBar from '@mui/material/AppBar';
import Box from '@mui/material/Box';
import CssBaseline from '@mui/material/CssBaseline';
import Toolbar from '@mui/material/Toolbar';
import Typography from '@mui/material/Typography';
import Drawer from '@mui/material/Drawer';
import MenuIcon from '@material-ui/icons/Menu';
import IconButton from '@mui/material/IconButton';
import Divider from '@mui/material/Divider';
import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';
import ListItemText from '@mui/material/ListItemText';
function header(props) 
{  
    const { window } = props;
    const container = window !== undefined ? () => window().document.body : undefined;
    const drawerWidth = 200;
  return (
    <Box sx={{ display: 'flex' }}>
      <CssBaseline />
      <AppBar
        position="fixed"
        sx={{
          width: { sm: `calc(112% - 200px)` },
          ml: { sm: `${drawerWidth}px` },backgroundColor:'transparent'
        }}
      >
        <Toolbar >
        <IconButton
            color="inherit"
            aria-label="open drawer"
            edge="start"
            sx={{ mr: 2, display: { sm:'flex'} }}
          >
            <MenuIcon onClick={()=>{props.setOpenDrawer(true)}}  />
          </IconButton>
          <Typography variant="h6" noWrap component="div"  >
            Admin Page
          </Typography>
        </Toolbar>
      </AppBar>
      <Box
        component="nav"
        sx={{ width: { sm: drawerWidth }, flexShrink: { sm: 0 } }}
        aria-label="mailbox folders"
      >
        {/* The implementation can be swapped with js to avoid SEO duplication of links. */}
       
        <Drawer
          variant='temporary'
          sx={{
            display: {  sm: 'block' },
            '& .MuiDrawer-paper': { boxSizing: 'border-box', width: drawerWidth },
          }}
          open={props.openDrawer}
          onClose={()=>{props.setOpenDrawer(false)}}
        >
            
          <Toolbar />
          <Typography variant='h6' align='center' sx={{mb:2}} >
                Admin's Name
         </Typography>
               
    <Divider />
    <List>
      {['Add Things To Do', 'Add Blogs', 'Add Trips',"View Details"].map((text, index) => (
        <ListItem button key={text} onClick={()=>{
            if(text.includes('Blogs'))
            {
                props.setOpenBlogs(true)
                props.setOpenAddThings(false)
                props.setOpenTrips(false)
            }
            else if(text.includes('Things'))
            {
                props.setOpenAddThings(true)
                props.setOpenBlogs(false)
                props.setOpenTrips(false)
            }
            else if(text.includes('Trips'))
            {
                props.setOpenTrips(true)
                props.setOpenAddThings(false)
                props.setOpenBlogs(false)
            }
        }} >
          
          <ListItemText primary={text} style={{padding:20}} >
                {text}    
          </ListItemText>
        </ListItem>
      ))}
    </List>
    <Divider />
        </Drawer>
      </Box>
      </Box>
  )
}

export default header