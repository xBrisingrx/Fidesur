module ApplicationHelper
	def format_number(num)
		number_to_currency(num, {:unit => '', :separator => ',', :delimiter => '.', :precision => 2})
	end
end
