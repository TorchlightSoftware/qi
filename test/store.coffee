should = require 'should'
{store} = require '..'

describe 'store', ->

  it 'should accept a preset number of subcallbacks', (done) ->
    cb = store done, 3

    setTimeout cb, 1
    setTimeout cb, 2
    setTimeout cb, 3

  it 'should not call done twice', (done) ->
    cb = store done, 2

    setTimeout cb, 1
    setTimeout cb, 2
    setTimeout cb, 3

  it 'should timeout', (done) ->

    # we should not modify 'trap' if it works correctly
    trap = 'ready'
    trigger = -> trap = 'sprung!'

    cb = store trigger, 3

    setTimeout cb, 1
    setTimeout cb, 2

    finished = ->
      trap.should.eql 'ready'
      done()

    setTimeout finished 10
