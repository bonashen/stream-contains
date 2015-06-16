Stream = require('stream')
inOrNot = require('../inOrNot')

generator = (n) ->
  s = new Stream
  i = 1

  next = ->
    s.emit 'data',
      name: 'name ' + i
      value: Math.floor((i + Math.random()) * 100)
      age: Math.floor(i * 100* Math.random()%70)
      n_value:i
      grade:
        name: 'grade ' + (i % 6 + 1)
    i++
    if i == n
      s.emit 'end'
    else
      process.nextTick next
    return

  s.readable = true
  process.nextTick next
  s

generator(100)
.pipe(inOrNot.in([35..40], 'age'))
.on('data', (doc)->
    console.log doc
).once 'end',  ->
  console.log 'end'
