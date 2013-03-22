module.exports = (fns..., cb) ->
  index = 0
  callNext = (args...) ->

    unless index < fns.length
      return cb null, args...

    fns[index] args..., (err, results...) ->
      return cb err, results... if err
      index++
      callNext results...
