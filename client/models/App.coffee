#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on 'bust', => 
    	do @bust

    @get('dealerHand').on 'bust', => 
      do @won

    @get('playerHand').on 'done', => 
      do @get('dealerHand').playDealer
    
    @get('dealerHand').on 'done', =>
      playerScore = @get('playerHand').scores()
      dealerScore = @get('dealerHand').scores()
      
      if (playerScore is dealerScore)
        do @draw

      if (playerScore < dealerScore)
        do @lost

      if (playerScore > dealerScore)
        if playerScore is 21
          do @blackjack
        else
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