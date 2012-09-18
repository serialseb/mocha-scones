Mocha = require 'mocha'
util = require 'util'

Story 'In order to communicate my results I can structure stories and features', ->
  i = 0
  Feature 'Feature code block', ->
    Given 'I have a feature block', ->
      i += 1
    When 'I execute some code', ->
      i += 1
    Then 'the result is correct', ->
      i.should.equal 2