const voot_controller = require('../controller/vootCounter')
const express = require('express')
const voot_router = express.Router()

voot_router.route('/up').get(voot_controller.vootcount)
module.exports = voot_router