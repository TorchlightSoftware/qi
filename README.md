# Qi

A simple DSL for parallel and sequential processing.

It is simpler and smaller than any other flow control library you will find, and the features are so powerful, it's probably a monad.

It supports three operations:

* disperse
* focus
* channel

```bash
npm install qi
```

## Focus

Initialize it on a target function and you will get a callback constructor.  You may create as many callbacks as you want and pass them to your subtasks.  The target will be called when the subtasks have completed.

It supports the node convention of (err, data).  If any of your subtasks return results they will be accumulated in an array.  If any return an error, the target will be called immediately with the error, and the results of all further subtasks will be ignored.

### Example

```coffee-script
should = require 'should'
{focus} = require 'qi'

describe 'focus', ->
  it 'should wait for all callbacks to return', (done) ->
    cb = focus done

    setTimeout cb(), 1
    setTimeout cb(), 2
    setTimeout cb(), 3

  it 'should return all results', (done) ->
    cb = focus (err, results) ->
      should.not.exist err
      results.should.eql [0, 1]
      done()

    i = 0
    doStuff = (cb) ->
      -> cb null, i++

    setTimeout doStuff(cb()), 1
    setTimeout doStuff(cb()), 2
```

## Disperse

This creates a function which when called will pass its args on to multiple child functions.

### Example

```coffee-script
should = require 'should'
{disperse} = require 'qi'

describe 'disperse', ->
  it 'should call all callbacks', ->

    yin = (input) ->
      input.should.eql 1

    yang = (input) ->
      input.should.eql 1

    taiji = disperse yin, yang
    taiji 1
```

## Channel

This executes any number of tasks in sequence.

### Example

```coffee-script
should = require 'should'
{channel} = require 'qi'

describe 'channel', ->
  it 'should call multiple functions', (done) ->

    task1 = (arg, next) ->
      next null, arg * 4

    task2 = (arg, next) ->
      next null, arg + 2

    final = (err, arg) ->
      should.not.exist err
      should.exist arg
      arg.should.eql 42
      done()

    sequence = channel(task1, task2)
    sequence 10, final

```

## LICENSE

(MIT License)

Copyright (c) 2013 Torchlight Software <info@torchlightsoftware.com>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
