const user_food = require('../controller/userFood.controller')
const adminCheck = require('../middleware/AdminCheck')
const express = require('express')
const u_food_route = express.Router()

u_food_route.route('/vote').post(user_food.upvote)
u_food_route.route('/people').post(adminCheck.adminCheck, user_food.viewAll)

module.exports = u_food_route