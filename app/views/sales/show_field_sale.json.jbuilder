json.data @batch_payments do |b|
	json.number b.number
	json.money b.money
	json.due_date b.due_date
	json.payed b.payed
	json.actions 'none'
end

