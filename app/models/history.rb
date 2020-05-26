class History < ApplicationRecord
	include DestroyedAt

	belongs_to :source, 	 :foreign_key => :source_account_id, :class_name => 'Account', optional: true
	belongs_to :destination, :foreign_key => :dest_account_id,   :class_name => 'Account', optional: true

	validates_presence_of :action, :value

	ACTION_WITHDRAW = "saque"
	ACTION_DEPOSIT  = "deposito"
	ACTION_TRANSFER = "transferencia"



end
