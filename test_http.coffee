http = require 'http'
fs = require 'fs'
Q = require 'q'


getFileStats = (path) ->
  Q.nfcall fs.readdir, path
  .then (files) ->
    Q.all files.map (file) ->
      Q.nfcall fs.stat, file
  .then (stats) ->
    console.log 'file stats:'
    stats


http.createServer (req, res) ->
  getFileStats './'
  .then (stats) ->
    res.writeHead 200,
      'Content-Type' : 'application/json; charset=utf-8'
    res.end JSON.stringify(stats)
  , (err) ->
    res.writeHead 500,
      'Content-Type' : 'application/json; charset=utf-8'
    res.end JSON.stringify(err)

.listen 1337, 'localhost'
