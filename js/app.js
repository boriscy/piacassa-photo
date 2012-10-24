// Generated by CoffeeScript 1.3.3
(function() {
  var Product,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  Product = (function(_super) {

    __extends(Product, _super);

    function Product() {
      return Product.__super__.constructor.apply(this, arguments);
    }

    Product.prototype.initialize = function() {
      this.on('change:price change:quantity', this.setSubtotal);
      this.on('change:item', this.setPrice);
      return this.setSubtotal();
    };

    Product.prototype.defaults = {
      price: 0,
      quantity: 1,
      subtotal: 0
    };

    Product.prototype.setPrice = function() {
      return this.set('price', this.get('item') * 1);
    };

    Product.prototype.setSubtotal = function() {
      var sub;
      sub = 1 * this.get("quantity") * 1 * this.get("price");
      return this.set('subtotal', sub);
    };

    return Product;

  })(Backbone.Model);

  this.ProductsList = (function(_super) {

    __extends(ProductsList, _super);

    function ProductsList() {
      this.addProduct = __bind(this.addProduct, this);
      return ProductsList.__super__.constructor.apply(this, arguments);
    }

    ProductsList.prototype.model = Product;

    ProductsList.prototype.total = 0;

    ProductsList.prototype.initialize = function(list, total) {
      this.list = list;
      this.total = total;
      return this.on('change', this.calculateTotal);
    };

    ProductsList.prototype.calculateTotal = function() {
      var tot;
      tot = this.reduce(function(sum, p) {
        return sum + p.get('subtotal');
      }, 0);
      return $(this.total).html(tot);
    };

    ProductsList.prototype.setList = function() {
      var _this = this;
      return $(this.list).each(function(i, el) {
        var p;
        _this.add(p = new Product());
        return rivets.bind(el, {
          product: p
        });
      });
    };

    ProductsList.prototype.addProduct = function() {
      var loc, p, tr;
      loc = "" + this.list + ":last";
      $(loc).after($('#product-template').html());
      console.log($('#product-template').html());
      tr = $(loc).get(0);
      this.add(p = new Product());
      return rivets.bind(tr, {
        product: p
      });
    };

    ProductsList.prototype.removeProduct = function() {};

    return ProductsList;

  })(Backbone.Collection);

}).call(this);