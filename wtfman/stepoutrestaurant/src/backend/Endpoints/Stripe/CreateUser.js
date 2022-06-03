import React from 'react'
import axios from 'axios'

export const CreateUser = async function (email) {
    const url = "https://stripe-subscription-api.herokuapp.com/create-stripe-user"
    const body ={email:email}
    try{
        return  axios.post(url,body);
    }catch(err){
        return err;
    }
   
}
