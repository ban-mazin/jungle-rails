require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validation' do
    it 'should save a product' do  
      @category = Category.create!(:name => 'aperal')
      @product = Product.new(
        :name => 'Human Feet Shoes',
        :quantity => 82,
        :price => 224.50,
        :category => @category)
      @product.save!
      expect(@product.name).to be_present
    end
    it 'should have a name' do
      @category = Category.create!(:name => 'aperal')
      @product = Product.new(:name => nil,
      :category => @category,
      :quantity => 82,
      :price => 224.50 )
      @product.valid?
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end
    it 'should have a price' do
      @category = Category.create!(:name => 'aperal')
      @product = Product.new(:name => "Hello",
      :category => @category,
      :quantity => 82,
      :price => nil )
      @product.valid?
      expect(@product.errors.full_messages).to include("Price is not a number")
    end
    it 'should have a quanity' do
      @category = Category.create!(:name => 'aperal')
      @product = Product.new(:name => "Hello",
      :category => @category,
      :quantity => nil,
      :price => 66 )
      @product.valid?
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end
    it 'should have a category' do
      @category = Category.create!(:name => 'aperal')
      @product = Product.new(:name => "Hello",
      :category => nil,
      :quantity => 3,
      :price => 66 )
      @product.valid?
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end