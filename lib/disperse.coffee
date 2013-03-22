module.exports = (fns...) ->
  (args...) ->
    fn args... for fn in fns
