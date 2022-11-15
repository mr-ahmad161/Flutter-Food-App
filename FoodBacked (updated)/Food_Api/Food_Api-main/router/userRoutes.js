const express = require('express')
const u_controller = require('../controller/signup')
const login_control = require('../controller/login')
const u_router = express.Router()
u_router.route('/signup').post(u_controller.signup)
u_router.route('/update/:id').patch(u_controller.upadte)
u_router.route('/login').post(login_control.login)
u_router.route('/find').get(login_control.get)
u_router.route('/me').get(login_control.me)


module.exports = u_router