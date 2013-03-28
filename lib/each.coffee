store = require './store'

module.exports = (arr, iterator, done) ->
  next = store done, arr.length
  arr.forEach (item) ->
    iterator item, next
