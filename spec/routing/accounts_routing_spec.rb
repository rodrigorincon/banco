require "rails_helper"

RSpec.describe AccountsController, type: :routing do
  describe "routing" do
    
    it "routes to #balance" do
      expect(:get => "/accounts/balance").to route_to("accounts#balance")
    end

    it "routes to #history" do
      expect(:get => "/accounts/history").to route_to("accounts#history")
    end

    it "routes to #withdraw_page" do
      expect(:get => "/accounts/withdraw_page").to route_to("accounts#withdraw_page")
    end

    it "routes to #deposit_page" do
      expect(:get => "/accounts/deposit_page").to route_to("accounts#deposit_page")
    end

    it "routes to #transfer_page" do
      expect(:get => "/accounts/transfer_page").to route_to("accounts#transfer_page")
    end

    it "routes to #withdraw" do
      expect(:post => "/accounts/withdraw").to route_to("accounts#withdraw")
    end
    
    it "routes to #deposit" do
      expect(:post => "/accounts/deposit").to route_to("accounts#deposit")
    end

    it "routes to #transfer" do
      expect(:post => "/accounts/transfer").to route_to("accounts#transfer")
    end
    
  end
end
