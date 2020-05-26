require 'rails_helper'

RSpec.describe "accounts/new", type: :view do
  before(:each) do
    assign(:account, Account.new(
      :user => nil,
      :money => "9.99",
      :agency => 1,
      :bank_account => 1
    ))
  end

  it "renders new account form" do
    render

    assert_select "form[action=?][method=?]", accounts_path, "post" do

      assert_select "input[name=?]", "account[user_id]"

      assert_select "input[name=?]", "account[money]"

      assert_select "input[name=?]", "account[agency]"

      assert_select "input[name=?]", "account[bank_account]"
    end
  end
end
