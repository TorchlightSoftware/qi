should = require 'should'
{disperse} = require '..'

describe 'disperse', ->
  it 'should call all subtasks', ->

    yin = (input) ->
      input.should.eql 1

    yong = (input) ->
      input.should.eql 1

    taichi = disperse yin, yong
    taichi 1
