const dotenv = require('dotenv')
const mongoose = require('mongoose')
const app = require('./app')
dotenv.config(process.env.DB)
mongoose.connect(process.env.DB, () => {
  console.log('DB connected')
})
app.listen(process.env.PORT || 6000, () => {
  console.log(`listening on port ${process.env.PORT}`)
})
