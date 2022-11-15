const user_food = require('../model/userFood.schema')
const user = require('../model/userSchema')
const food = require('../model/foodSchema')
exports.upvote = async (req, res) => {
    try {
        console.log("===== Data =====", req.body);

        const email = req.body.email
        const userObj = await user.findOne({ email: email })
        if(userObj){
        const obj = await user_food.create({
            userId: userObj.id,
            ...req.body,
        })
        }
    
        res.status(200).json({
            message: "UpVoted Successfuly",
        })
    } catch (e) {
        res.status(400).json({
            message: "Page Not Found",

        })
        console.log("===== Error =====", e.message);
    }
}

exports.viewAll = async (req, res) => {
    try {
        const voots = await user_food
            .find()
            .populate('userId', 'fullName')
            .populate('foodId', 'foodName')
        res.status(200).json({
            status: "Success",
            data: voots
        })
    } catch (e) {
        console.log(e)
        res.status(400).json({
            status: "Fail",
            Error: e
        })
    }
}