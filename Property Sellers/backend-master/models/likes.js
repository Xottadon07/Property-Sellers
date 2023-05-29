const mongoose = require('mongoose')

const likeSchema = new mongoose.Schema({


    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
        required: true,
    },

    product: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Product",
        required: true,
    },

}, {
    timestamps: true
})

const Like = mongoose.model("Like", likeSchema)

module.exports = Like