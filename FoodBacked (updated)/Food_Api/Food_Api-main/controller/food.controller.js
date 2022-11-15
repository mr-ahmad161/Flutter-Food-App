const food = require('../model/foodSchema')
const user = require('../model/userSchema')

exports.addFood = async (req, res) => {

    try {
        const obj = await food.create(req.body)
        res.status(200).json({
            message: "Successfuly added",
            food: obj
        })
    } catch (e) {
        res.status(400).json({
            message: "Page Not Found",
            Error: e
        })

    }
}

exports.findAll = async (req, res) => {
    try {
        const allFood = await food.find()
        res.status(200).json({
            message: "Request Successful",
            data: allFood
        })
    } catch (e) {
        res.status(400).json({
            message: "Page Not Found",
            Error: e
        })
    }
}