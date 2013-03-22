module.exports = (fns..., done) ->
  index = 0
  callNext = (args...) ->

    unless index < fns.length
      return done null, args...

    fns[index] args..., (err, results...) ->
      return done err, results... if err
      index++
      callNext results...
