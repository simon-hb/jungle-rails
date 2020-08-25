require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    # each example will needs its own @category created
    before (:each) do
      @category = Category.new(name: 'Technology')
    end

    context "fields" do
      it 'should save each field successfully' do
        @product = Product.new(name:'jphone', price: 500, quantity: 1, category: @category)
        expect(@product.name).to be_present
        expect(@product.price).to be_present
        expect(@product.quantity).to be_present
        expect(@product.category).to be_present
      end
    end

    context "name" do
      it 'should produce error without name' do
        @product = Product.new(name: nil, price: 500, quantity: 1, category: @category)
        expect(@product).to_not be_valid
        @product.save
        # puts @product.errors.messages.inspect 
        # ^this prints error message so we know what to include for the expect test
        expect(@product.errors.messages[:name]).to include("can't be blank")
      end
    end

    context "price" do
      it 'should produce error without price' do
        @product = Product.new(name:'jphone', price: nil, quantity: 1, category: @category)
        expect(@product).to_not be_valid
        @product.save
        expect(@product.errors.messages[:price]).to include("can't be blank")
      end
    end

    context "quanitity" do
      it 'should produce error without quantity' do
        @product = Product.new(name:'jphone', price: 500, quantity: nil, category: @category)
        expect(@product).to_not be_valid
        @product.save
        expect(@product.errors.messages[:quantity]).to include("can't be blank")
      end
    end

    context "category" do
      it 'should produce error without category' do
        @product = Product.new(name:'jphone', price: 500, quantity: 1, category: nil)
        expect(@product).to_not be_valid
        @product.save
        expect(@product.errors.messages[:category]).to include("can't be blank")
      end
    end
  end
end