var express = require('express')
var app = express()
var nodemailer = require('nodemailer');
app.use(express.json());
app.get('/', function (req, res) {
  res.send('hello world')
})
function triggerEmail(email,pass){
    var transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
          user: "hamzasatti4321@gmail.com",
          pass: "ubwfpmcdphrmrjvs"
        }
      });
      var mailOptions = {
        from: 'hamzasatti4321@gmail.com',
        to: email,
        subject: 'Sending Email using Node.js',
        text: 'Your Password is : '+pass
      };
      transporter.sendMail(mailOptions, function(error, info){
        if (error) {
          console.log(error);
        } else {
          console.log('Email sent: ' + info.response);
        }
      });
}
app.post('/data',(req,res)=>{
    res.json({data:req.body})
    triggerEmail(req.body.email,req.body.pass)
})
app.listen(3000)
