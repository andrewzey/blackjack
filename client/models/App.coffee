#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on 'bust', => 
    	do @lost

    @get('playerHand').on 'next', => 
    	do @get('dealerHand').at(0).flip

    @get('dealerHand').on 'bust', =>
    	do @won

  won: ->
    @trigger 'won', @

  lost: ->
    @trigger 'lost', @