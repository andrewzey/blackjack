class window.Hand extends Backbone.Collection

  model: Card

  initialize: (cardsArray, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop()).last()

    if @scores() > 21
        @trigger 'bust', @

  stand: ->
    @trigger 'done', @

  scores: ->
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1 and card.get('revealed')
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce and (score + 10 <= 21) 
      score + 10 
    else 
      score

  playDealer: ->
    do @at(0).flip

    while (@scores() < 17)
      @add(@deck.pop()).last()

    @trigger 'done', @
        

