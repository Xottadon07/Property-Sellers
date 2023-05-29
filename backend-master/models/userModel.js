const mongoose = require('mongoose')
const Schema = mongoose.Schema

const newSchema = new Schema({
    username:String,
    password:String,
    phoneNumber:String,
    email:String
})


const User = mongoose.model('User',newSchema)
module.exports = User 