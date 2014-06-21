class window.CardView extends Backbone.View

  className: 'card'

  template: _.template '<%= rankName %> of <%= suitName %>'

  initialize: ->
    @model.on 'change', => @render
    @render()

  render: ->
    rank = @model.get('rankName')
    suit = @model.get('suitName')
    @$el.children().detach().end().html
    @$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'
    if @model.get('revealed') then @$el.css('background-image', "url('img/cards/#{rank}-#{suit}.png')")
