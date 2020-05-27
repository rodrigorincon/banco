module TransferTaxRules
  extend ActiveSupport::Concern
  
  def get_transfer_tax(value)
    tax = 0
    if today_is_week_of_day? && Time.now.hour >= 9 && Time.now.hour <= 18
      tax = 5
    else
      tax = 7
    end

    if value > 1000.0
      tax += 10
    end

    tax
  end

  def today_is_week_of_day?
    (1..5).include?(Date.today.wday)
  end

end