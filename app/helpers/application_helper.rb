module ApplicationHelper
	def format_number(num)
		number_to_currency(num, {:unit => '', :separator => ',', :delimiter => '.', :precision => 2})
	end

	def active_class(link_path)
	    current_page?(link_path) ? "active" : ""
	end
end
