const mongoose = require('mongoose')

const foodSchema = mongoose.Schema({
    foodName: {
        type: String,
        require: [true, "food name must not be empty"]
    },
    foodPrice: {
        type: Number,
        require: true
    }
}, {
    timestamps: true
})
const food = mongoose.model('food', foodSchema)
module.exports = food
