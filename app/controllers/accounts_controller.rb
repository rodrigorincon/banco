class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account
  
  def balance
  end

  def history
    # default filter, brings the last 7 days
    @begin_date = params[:begin_date] ? params[:begin_date] : Date.today - 7.days
    @end_date = params[:end_date] ? params[:end_date] : Date.today

    dest_account_sql = History.where(dest_account_id: @account.id)
    @history = History.where(source_account_id: @account.id).or(dest_account_sql)
                      .where(created_at: @begin_date.beginning_of_day..@end_date.end_of_day)
                      .order(created_at: :asc)
  end

  def deposit
  end

  def withdraw
  end

  private

  def set_account
    @account = Account.find_by(user_id: current_user.id)
  end

end
