
const mongoose =   require('mongoose')
mongoose.connect("mongodb://localhost:27017/afno_zamin",{ useNewUrlParser: true, useUnifiedTopology: true ,
autoIndex: false, // Don't build indexes
    maxPoolSize: 10, // Maintain up to 10 socket connections
    serverSelectionTimeoutMS: 5000, // Keep trying to send operations for 5 seconds
    socketTimeoutMS: 45000, // Close sockets after 45 seconds of inactivity
    family: 4 
}).then(()=>{
    console.log('connected!');
}).catch((e)=>{
    console.log(e)
    console.log('sorry!');

})

