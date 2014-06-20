assert = chai.assert

describe 'App Model', ->
  app = null

  beforeEach ->
    app = new App()


  describe 'win/loss', ->
    it "should trigger win event", ->
      won = false
      app.on('won', -> won = true)
      do app.won
      assert.strictEqual (won), true

    it "should trigger lost event", ->
      lost = false
      app.on('lost', -> lost = true)
      do app.lost
      assert.strictEqual (lost), true
