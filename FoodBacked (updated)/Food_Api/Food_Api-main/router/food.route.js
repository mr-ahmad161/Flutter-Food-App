const food_controller = require('../controller/food.controller')
const adminCheck = require('../middleware/AdminCheck')
const express = require('express')
const food_route = express.Router()

food_route.route('/add').post(adminCheck.adminCheck, food_controller.addFood)
food_route.route('/find').get(food_controller.findAll)

module.exports = food_route