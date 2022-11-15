const userM = require('../model/userSchema')
const bcrypt = require('bcrypt')
exports.login = async (req, res) => {
  try {
    const email = req.body.email
    const password = req.body.password
    const obj = await userM.findOne({ email: email })
    if (!obj) {
      res.status(400).json({
        message: 'User Not Found',
      })
    }
    const access = await bcrypt.compare(password, obj.password)
    if (access) {
      res.status(200).json({
        message: 'Successfuly login',
        emai: obj.email,
        fullName: obj.fullName,
        role: obj.role,
      })
    } else {
      res.status(400).json({
        message: 'Login fail',
      })
    }
  } catch (e) {
    console.log(e)
    res.status(400).json({
      message: 'Login fail',
    })
  }
}
exports.get = async (req, res) => {
  const obj = await userM.find()
  if (!obj) {
    res.status(400).json({
      message: 'Something went Wrong',
    })
  }
  res.json({
    data: obj,
  })
}

exports.me = async (req, res) => {
  console.log(req.query)
  const user = await userM.findOne({
    email: req.query.email
  })
  .select({
    password: 0,
    __v: 0
  })
  if (!user) {
    res.status(400).json({
      message: 'Something went Wrong',
    })
    return
  }
  res.json(user)
  // const user = await userM.find({
  //   email: req.query
  // })
}
