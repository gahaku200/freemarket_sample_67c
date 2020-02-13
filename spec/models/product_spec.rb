require 'rails_helper'
describe Product do
  describe '#create' do
    it "is invalid without a name" do
      product = build(:product, name: '')
      product.valid?
      expect(product.errors[:name]).to include("can't be blank")
    end

    it "is invalid without a description" do
      product = build(:product, description: '')
      product.valid?
      expect(product.errors[:description]).to include("can't be blank")
    end

    it "is invalid without a status_id" do
      product = build(:product, status_id: '')
      product.valid?
      expect(product.errors[:status_id]).to include("can't be blank")
    end

    it "is invalid without a delivery_charge_id" do
      product = build(:product, delivery_charge_id: '')
      product.valid?
      expect(product.errors[:delivery_charge_id]).to include("can't be blank")
    end

    it "is invalid without a delivery_days_id" do
      product = build(:product, delivery_days_id: '')
      product.valid?
      expect(product.errors[:delivery_days_id]).to include("can't be blank")
    end

    it "is invalid without a price" do
      product = build(:product, price: '')
      product.valid?
      expect(product.errors[:price]).to include("can't be blank")
    end

    it "is invalid without a ship_from_id" do
      product = build(:product, ship_from_id: '')
      product.valid?
      expect(product.errors[:ship_from_id]).to include("can't be blank")
    end
  end
end