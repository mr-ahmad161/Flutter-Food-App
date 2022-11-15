const user_food = require('../model/userFood.schema')
const food = require('../model/foodSchema')
exports.vootcount = async (req, res) => {
    try {
        const votings = await user_food.aggregate([{
            $group: {
                _id: '$foodId',
                count: {
                    $sum: 1
                }
            }
        }])
        let voted = 0
        let favour
        votings.forEach((obj) => {
            if (voted < obj.count) {
                voted = obj.count
                favour = obj
            }
        })
        const favrt = await food.findById(favour._id)
        res.status(200).json({
            message: "successful",
            favrt
        })
    } catch (e) {
        res.status(400).json({
            message: "Page Not Found",
            erroe: e
        })
    }
}