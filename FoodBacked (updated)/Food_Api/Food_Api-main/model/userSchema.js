const mongoose = require('mongoose')

var validateEmail = function (email) {
  var re = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/
  return re.test(email)
}

const userSchema = mongoose.Schema({
  fullName: {
    type: String,
    require: true,
    max: 25,
  },
  email: {
    type: String,
    validate: [validateEmail, 'Should be valid Email'],
    require: [true, 'Email required'],
    unique: [true, 'should be unique'],
  },
  password: {
    type: String,
    require: true,
    min: 8,
  },
  role: {
    type: String,
    default: 'User',
  },
})

const user = mongoose.model('user', userSchema)
module.exports = user
