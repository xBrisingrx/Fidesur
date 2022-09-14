class FeesController < ApplicationController
	
	def index
		# Obtengo las cuotas de una venta
		@fees = Fee.where(sale_id: params[:sale_id]).where('number != 0')
		@status = { 'pendiente' => 'Pendiente', 'pagado' => 'Pagada', 'pago_parcial' => 'Pago parcial'}
	end

	def show
		
	end
end
