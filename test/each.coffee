should = require 'should'
{each} = require '..'

describe 'each', ->

  it 'should map a list', (done) ->

    square = (item, next) ->
      next null, item * item

    each [1, 2, 3], square, (err, result) ->
      should.not.exist err
      should.exist result
      result.should.eql [1, 4, 9]
      done()
