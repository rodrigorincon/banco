require 'rails_helper'

RSpec.describe "accounts/edit", type: :view do
  before(:each) do
    @account = assign(:account, Account.create!(
      :user => nil,
      :money => "9.99",
      :agency => 1,
      :bank_account => 1
    ))
  end

  it "renders the edit account form" do
    render

    assert_select "form[action=?][method=?]", account_path(@account), "post" do

      assert_select "input[name=?]", "account[user_id]"

      assert_select "input[name=?]", "account[money]"

      assert_select "input[name=?]", "account[agency]"

      assert_select "input[name=?]", "account[bank_account]"
    end
  end
end
