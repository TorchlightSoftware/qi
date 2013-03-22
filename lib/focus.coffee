module.exports = (done) ->
  counter = 0
  error = null
  results = []

  (ref) ->
    ref or= counter
    counter++
    called = false

    (err, result) ->
      return if error
      return if called

      called = true
      if err
        error = err
        return done err, results

      results[ref] = result
      if --counter is 0
        done null, results
