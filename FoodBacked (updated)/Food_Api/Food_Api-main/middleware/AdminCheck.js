const user = require('../model/userSchema')
exports.adminCheck = async (req, res, next) => {
    try {

        const email = req.body.email
        const client = await user.findOne({ email: email })
        if (client.role !== 'Admin') {
            res.status(400).json({
                message: "You Donot Have Permission"
            })
        } else {

            next()
        }
    } catch (e) {
        console.log(e);
        res.status(400).json({
            message: "something Went Wrong",
            error: e
        })
    }
}