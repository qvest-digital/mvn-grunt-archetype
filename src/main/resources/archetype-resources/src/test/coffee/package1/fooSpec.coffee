foo = require 'package1/foo'


describe 'Foo Module', ->

  describe 'add()', ->

    it 'adds two numbers', ->

      (expect foo.add 2, 3).toBe 5
