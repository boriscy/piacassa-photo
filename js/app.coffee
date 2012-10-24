class Product extends Backbone.Model
  initialize: ->
    @on('change:price change:quantity', @setSubtotal)
    @on('change:item', @setPrice)
    @setSubtotal()
  # Defaults
  defaults: {
    price: 0,
    quantity: 1,
    subtotal: 0
  },
  setPrice: ->
    @set('price', @get('item') * 1)
  # subtotal
  setSubtotal: ()->
    sub = 1 * this.get("quantity") * 1 * this.get("price")
    @set('subtotal', sub)

# Products list class
class @ProductsList extends Backbone.Collection
  model: Product,
  total: 0,
  initialize: (@list, @total)->
    @on('change', @calculateTotal)
  # Calculate total sum
  calculateTotal: ->
    tot = @reduce((sum, p)->
      sum + p.get('subtotal')
    , 0)
    $(@total).html(tot)
  # List
  setList: ->
    $(@list).each (i, el)=>
      @add(p = new Product())
      rivets.bind(el, {product: p})
  #
  addProduct: =>
    loc = "#{@list}:last"
    $(loc).after($('#product-template').html())
    console.log $('#product-template').html()
    tr = $(loc).get(0)

    @add(p = new Product())
    rivets.bind(tr, {product: p})
  #
  removeProduct: ->
