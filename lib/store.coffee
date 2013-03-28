module.exports = (done, count) ->
  counter = count or 1
  error = null
  results = {}

  (err, result) ->
    return if error

    if err
      error = err
      return done err, results

    results[count - counter] = result
    if --counter is 0
      done null, results
