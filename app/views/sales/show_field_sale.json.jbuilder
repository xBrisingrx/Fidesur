json.data @land_fees do |b|
	json.number b.number
	json.fee_value b.fee_value
	json.due_date b.due_date
	json.payed b.payed
	json.actions 'none'
end

