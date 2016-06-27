Q = require 'q'
request = require 'request'
fs = require 'fs'


requestGetQ = Q.nbind request.get, request

get2Save = (url, fileName) ->
  (request.get url).pipe fs.createWriteStream(fileName)


testUrl = 'http://nodejs.org/api/fs.html'

Q.Promise( (resolve, reject, notify) ->
  request.get testUrl, (err, res) ->
    if err
      reject new Error('This is an error')
    else
      resolve res
).then (res) ->
  #console.log 'The response is ', res


###
requestGetQ testUrl
.then (err, res, body) ->

  console.log 'err', err
  console.log 'res', res.statusCode
  console.log 'body', res.body

###

imgUrl = 'http://upload.wikimedia.org/wikipedia/en/9/9d/Maggie_Simpson.png'

#get2Save  imgUrl, 'simpson.png'


Q.nfcall fs.stat, './package.json'
.then (err, stat) ->
  console.log 'file stat is... '
  console.log err