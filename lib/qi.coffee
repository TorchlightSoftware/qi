module.exports = qi =
  focus: require './focus'
  disperse: require './disperse'
  channel: require './channel'
  qigong: (tasks, flow) ->
    (data, done) ->
      final = qi.focus done

      for step in flow
        for task, prereq of step
          pipe = qi.channel tasks[prereq], tasks[task]
          pipe data, final(task)
