require 'rails_helper'
describe Address do
  describe '#create_address' do

    it "zipcode: format [0-9]{3}-[0-9]{4}" do
      address = build(:address, zipcode: "123-1234")
      expect(address).to be_valid
    end

  end
end