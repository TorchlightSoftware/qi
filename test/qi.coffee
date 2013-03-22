should = require 'should'
{qigong, disperse, focus, channel} = require '..'

describe 'qi', ->
  it 'should work together', (done) ->

    # some computations to be chained
    comp1 = (next) -> next null, 5
    comp2 = (num, next) -> next null, num
    comp3 = (next) -> next null, 8
    comp4 = (num, next) -> next null, num * 2

    # analyze the final results
    finish = (err, results) ->
      should.not.exist err
      should.exist results
      results.should.eql {
        local: { comp1: 5, comp2: 3 },
        remote: { comp1: 5, comp4: 16 }
      }
      done()

    final = focus finish
    local = focus final('local')
    remote = focus final('remote')

    l1 = local('comp2')
    r1 = remote('comp4')

    # wire up all computations
    comp1 disperse local('comp1'), remote('comp1')
    comp2 3, l1
    channel(comp3, comp4)(r1)

describe 'qigong', ->
  #it 'should be awesome', (done) ->
    #tasks =
      #local: () ->
      #remote: () ->

      #preserve: () ->
      #swim: () ->
      #raid: () ->
      #kill: () ->
      #find: () ->

    #flow = [
        #local: ['preserve', 'swim']
        #remote: ['swim', 'raid']
      #,
        #raid: 'kill' # chain these together
        #kill: 'find' # chain these together
        #['foo', 'bar']: 'input'
    #]

  it 'should chain dependencies', (done) ->
    tasks =
      stuff1: (num, next) -> next null, num * 4
      stuff2: (num, next) -> next null, num + 2

    flow = [
        stuff2: 'stuff1'
    ]

    workflow = qigong tasks, flow
    workflow 10, (err, result) ->
      should.not.exist err
      should.exist result
      result.should.eql {stuff2: 42}
      done()

  it 'should chain more dependencies', (done) ->
    tasks =
      stuff1: (num, next) -> next null, num * 4
      stuff2: (num, next) -> next null, num + 2
      stuff3: (num, next) -> next null, num * 6
      stuff4: (num, next) -> next null, num - 13

    flow = [
      stuff2: 'stuff1'
      stuff3: 'stuff2'
      stuff4: 'stuff3'
    ]

    workflow = qigong tasks, flow
    workflow 10, (err, result) ->
      should.not.exist err
      should.exist result
      result.should.eql {stuff2: 42}
      done()
