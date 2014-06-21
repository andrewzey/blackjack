#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on 'bust', => 
    	do @bust

    @get('playerHand').on 'done', => 
      do @get('dealerHand').playDealer
    
    @get('dealerHand').on 'done', =>
      playerScore = @get('playerHand').scores()
      dealerScore = @get('dealerHand').scores()
      
      if (playerScore is dealerScore)
        do @draw

      else if playerScore is 21
        do @blackjack

      else if dealerScore > 21
        do @won

      else if (playerScore < dealerScore)
        do @lost

      else if (playerScore > dealerScore)
        do @won


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