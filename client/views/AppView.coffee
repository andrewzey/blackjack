class window.AppView extends Backbone.View

  template: _.template '
    <div class="game-status"><h2>Round is Not Over</h2></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    <button class="hit-button btn btn-success btn-lg">Hit</button>
    <button class="stand-button btn btn-success btn-lg">Stand</button>
    <button class="new-game btn btn-danger btn-lg">New Game</button>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()
    "click .new-game": -> $('.container').html(new AppView({model: new App()}).$el)

  initialize: ->
    @model.on('blackjack', => do @endgame('Blackjack'))
    @model.on('bust', => do @endgame('Bust'))
    @model.on('won', => do @endgame('Won'))
    @model.on('lost', => do @endgame('Lost'))
    @model.on('draw', => do @endgame('Draw'))
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  endgame: (status)->
    if (status is 'Blackjack')
      $('.game-status h2').text("You won with Blackjack!")

    if (status is 'Bust')
      $('.game-status h2').text("Game Over: You Busted!")

    if (status is 'Won')
      $('.game-status h2').text("You Won!")

    if (status is 'Lost')
      $('.game-status h2').text("You Lost!")

    if (status is 'Draw')
      $('.game-status h2').text("It's a Draw!")

    $('.game-status').css('visibility', 'visible')
    $('.new-game').css('visibility', 'visible')
    $('.hit-button').hide()
    $('.stand-button').hide()

