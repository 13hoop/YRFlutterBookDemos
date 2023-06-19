const jwt = require('jsonwebtoken');
const express = require('express');

const config = {
  secret: 'yyyrrr**',
  time: 60*60
}
function token(data, time) {
  let token = jwt.sign(data, config.secret, {
    algorithm: 'ES256',
    expiresIn: time || config.time
  })
  return token
}

var app = express();
app.use(express.json()) // for parsing application/json
app.use(express.urlencoded({ extended: true })) // for parsing application/x-www-form-urlencoded

app.post('/login', function (req, res, next) {
  console.log(Date() + '>> ', req.body)

  let body = req.body

  var msg = 'fail'
  var code = -1
  var user = null
  if (body.name == 'name' && body.pwd == '123456' ) {
    msg = 'success'
    code = 0
    user = {
      name: body.name,
      u_id: 888001,
      avatar: 'https://doc.flutterchina.club/images/flutter-mark-square-100.png'
    }
  }

  let data = {
    msg: msg,
    code: code,
    data: user
  }
  console.log(data)

  res.json(data)
})

app.get('/', function (req, res) {
  console.log('res is get !')
  res.send('hello world')
})

app.get('/videoCategory', function(req, res, next) {

  let list = [
    {
      title: '最新',
      category: 63
    },
    {
      title: '比赛',
      category: 64
    },
    {
      title: '最佳',
      category: 65
    },
    {
      title: '花絮',
      category: 66
    }
  ]
  let msg = 'success'
  let code = 0
  console.log(Date() + '>> ', req.url)
  let data = {
    msg: msg,
    code: code,
    data: list
  }
  console.log(data)
  res.json(data) 
})

app.listen(5555)