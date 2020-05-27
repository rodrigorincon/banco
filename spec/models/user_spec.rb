require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) {create(:user, :user1)}

  describe "create an new user" do
  	it "create an associated account" do
  		expect(user.account.present?).to be_truthy
  	end

  	it "the associated account is agency 1" do
  		expect(user.account.agency).to eq(1)
  	end
  end
end
