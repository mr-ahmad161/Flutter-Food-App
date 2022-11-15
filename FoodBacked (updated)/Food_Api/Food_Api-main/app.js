const express = require('express')
const u_router = require('./router/userRoutes')
const f_router = require('./router/food.route')
const u_food_route = require('./router/userFood.router')
const voot_router = require('./router/vootroute')
const app = express()
app.use(express.json())

app.use('/user', u_router)
app.use('/food', f_router)
app.use('/ufood', u_food_route)
app.use('/voot', voot_router)
module.exports = app
