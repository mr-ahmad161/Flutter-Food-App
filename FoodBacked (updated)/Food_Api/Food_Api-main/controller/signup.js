const userM = require('../model/userSchema')
const bcrypt = require('bcrypt')

exports.signup = async (req, res) => {
    try {
        //await bcrypt.genSalt(10)
        const password = req.body.password
        const pass = await bcrypt.hash(password, 6)
        req.body.password = pass
        const sObj = await userM.create(req.body)
        res.status(200).json({
            status: 'Success, User created with the following',
            Data: sObj,
        })
    } catch (e) {
        console.log(e)
        res.status(400).json({
            ERROR: `Page Not Found ${e}`,
        })
    }
}

exports.upadte = async (req, res) => {
    try {
        const id = req.params.id
        const rUpdate = req.body
        const obj = await userM.findByIdAndUpdate(id, rUpdate, { new: true })
        res.status(200).json({
            status: 'Success, User updated with the following',
            Data: obj,
        })
    } catch (e) {
        console.log(e)
        res.status(400).json({
            ERROR: `Page Not Found ${e}`,
        })
    }
}
