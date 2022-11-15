const mongoose = require('mongoose')
const { Schema } = require('mongoose')

const userFood = mongoose.Schema({
    foodId: {
        type: Schema.Types.ObjectId, ref: 'food',
        require: [true, "food name must not be empty"],
    },
    userId: {
        type: Schema.Types.ObjectId, ref: 'user',
        require: [true, "food name must not be empty"],
    },
    count: {
        type: Number,
        default: 1
    }
}, {
    timestamps: true
})
const user_food = mongoose.model('user_food', userFood)
module.exports = user_food
