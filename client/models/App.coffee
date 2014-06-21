#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on 'bust', => 
    	do @bust

    @get('playerHand').on 'done', =>
      playerScore = @get('playerHand').scores()
      console.log playerScore
    	#@get('dealerHand').playDealer()


  blackjack: ->
    @trigger 'blackjack', @

  bust: ->
    @trigger 'bust', @

  won: ->
    @trigger 'won', @

  lost: ->
    @trigger 'lost', @

  draw: ->
    @trigger 'draw', @