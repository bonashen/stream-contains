through = require('./util').through
readArray = require('./util').readArray

inOrNotIn = (notIn)->
  (arr, distinct)->
    right = if arr instanceof Array then readArray arr else arr
    distinct = do (distinct)->
      if 'function' is typeof distinct then distinct else (obj)->
        if 'object'==typeof obj
          obj[distinct]
        else#support
          obj

    map = {}
    queue = []
    endCount = 0

    analyse = ->
      doc = queue.shift();
      if(doc)
        if notIn ^ (map[distinct doc]!=undefined )
          left.emit 'data', doc

        process.nextTick analyse
      else
        left.emit 'end'
        queue=map=undefined
      return

    wait = ->
      endCount++
      if endCount == 2 then process.nextTick analyse
      return

    left = through queue.push.bind(queue), wait

    right.on('data',
      (doc)->
        map[distinct doc] = doc
        return
    ).once 'end', wait

    left


module.exports.in = inOrNotIn false
module.exports.notIn = inOrNotIn true