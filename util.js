/**
 * Created by bona on 2015/6/9.
 */
var through = require('through');
var Stream = require('stream');

function readArray(array) {
    var s = new Stream;
    var i = 0;
    if (array && array.length) {
        function next() {
            if (i < array.length) {
                s.emit('data', array[i]);
                ++i;
                process.nextTick(next);
            } else {
                s.emit('end');
            }
        }

        process.nextTick(next);
    }
    return s;
}

function writeArray(done) {
    if ('function' != typeof done)throw new Error("must set done callback!");
    var array = [];
    var s = through(function (doc) {
        array.push(doc);

    }, function () {
        done(array);

    });
    return s;
}

module.exports = {
    through: through,
    readArray: readArray,
    writeArray: writeArray
};