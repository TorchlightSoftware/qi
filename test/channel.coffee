should = require 'should'
{channel} = require '..'

describe 'channel', ->
  it 'should call multiple functions', (done) ->

    fn1 = (arg, next) ->
      next null, arg * 4

    fn2 = (arg, next) ->
      next null, arg + 2

    final = (err, arg) ->
      should.not.exist err
      should.exist arg
      arg.should.eql 42
      done()

    channel(fn1, fn2, final)(10)
