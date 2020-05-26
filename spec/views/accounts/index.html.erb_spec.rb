require 'rails_helper'

RSpec.describe "accounts/index", type: :view do
  before(:each) do
    assign(:accounts, [
      Account.create!(
        :user => nil,
        :money => "9.99",
        :agency => 2,
        :bank_account => 3
      ),
      Account.create!(
        :user => nil,
        :money => "9.99",
        :agency => 2,
        :bank_account => 3
      )
    ])
  end

  it "renders a list of accounts" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
