import React from 'react'
import LoadingGif from '../Public/Loader.gif'
import '../App.css'
function Loader() {
  return (
    <div>
    <img src={LoadingGif}  style={{width:'100%'}} alt="loading" className='LoadingStyle' />
    </div>
  )
}

export default Loader