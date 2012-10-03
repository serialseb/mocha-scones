mocha = require 'mocha'
Suite = mocha.Suite
Test = mocha.Test

Step = (suite, message, fn) =>
  suite.addTest(new Test(message, fn));

module.exports = mocha.interfaces['scones'] = (suite)=>
  console.log 'scones.coffee'
  suites = [suite]
  suite.on 'pre-require', (context)=>
    console.log 'pre-require'
    context.Story = (message, fn) =>
      suite = Suite.create(suites[0], message)
      suite.scone_type = 'Story'
      suites.unshift(suite)
      fn()
      suites.shift()

    context.Feature = context.Scenario = (message, fn) =>
      suite = Suite.create(suites[0], message)
      suite.scone_type = 'Feature'
      suites.unshift(suite)
      fn()
      suites.shift()

    context.Given = (message, fn) =>
      Step suites[0], 'Given ' + message, fn

    context.When = (message, fn) =>
      Step suites[0],'When ' + message, fn

    context.Then = (message, fn) =>
      Step suites[0],'Then ' + message, fn

    context.And = (message, fn) =>
      Step suites[0], 'And ' + message, fn

    context.before = (fn) ->
      suites[0].beforeAll(fn)

    context.after = (fn) ->
      suites[0].afterAll(fn)

    context.beforeEach = (fn) ->
      suites[0].beforeEach(fn)

    context.afterEach = (fn) ->
      suites[0].afterEach(fn)