#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'initialResult', null
    
  start: ->
    @get('playerHand').at(0).flip()
    @get('playerHand').at(1).flip()

    @get('dealerHand').at(1).flip()

    playerScore = @get('playerHand').scores()
    
    if playerScore > 21
      @get('dealerHand').at(0).flip()
      dealerScore = @get('dealerHand').scores()
      if dealerScore is 21 
        @set 'initialResult', 'draw'
      else
        @set 'initialResult', 'blackjack'

    @get('playerHand').on 'bust', => 
      @trigger 'bust', @

    @get('playerHand').on 'done', => 
      do @get('dealerHand').playDealer
    
    @get('dealerHand').on 'done', =>
      playerScore = @get('playerHand').scores()
      dealerScore = @get('dealerHand').scores()
      
      if (playerScore is dealerScore)
        @trigger 'draw', @

      else if dealerScore > 21
        @trigger 'won', @

      else if (playerScore < dealerScore)
        @trigger 'lost', @

      else if (playerScore > dealerScore)
        @trigger 'won', @
      

