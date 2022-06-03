import React from 'react'
import Snackbar from '@mui/material/Snackbar';
import { Alert } from '@mui/material';
function AlertMessages(props) {
   const {messageType,message,open,setOpen}=props
   const handleClose=()=>{
    setOpen(false)
   }
  return (
    <div>
         <Snackbar open={open} autoHideDuration={3000} onClose={handleClose}
         anchorOrigin={{
            vertical: "top",
            horizontal: "center"
         }}
         >
        <Alert onClose={handleClose} severity={messageType} sx={{ width: '100%' }}>
          {message}
        </Alert>
      </Snackbar>
    </div>
  )
}

export default AlertMessages