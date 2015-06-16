#stream-contains

 in or notin for stream contains,it's collection toolkit's part.
 
 
 ##example
 
 ```coffeescript
 ss = require 'stream-contains'
 
 generator(100)
 .pipe(ss.in([35..40], 'age'))
 .on('data', (doc)->
     console.log doc
 ).once 'end',  ->
   console.log 'end'

```