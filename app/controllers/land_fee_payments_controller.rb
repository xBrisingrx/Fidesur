class LandFeePaymentsController < ApplicationController
  before_action :set_land_fee_payment, only: %i[ show edit update destroy ]

  # GET /land_fee_payments or /land_fee_payments.json
  def index
    @land_fee_payments = LandFeePayment.all
  end

  # GET /land_fee_payments/1 or /land_fee_payments/1.json
  def show;end

  # GET /land_fee_payments/new
  def new
    @title_modal = 'Pago parcial'
    @currencies = Currency.where(active:true)
    @land_fee = LandFee.find(params[:land_fee_id])
    @data = @land_fee.land_fee_payments.build
    @land_fee_payment = LandFeePayment.new
  end

  # GET /land_fee_payments/1/edit
  def edit;end

  # POST /land_fee_payments or /land_fee_payments.json
  def create
    land_fee = LandFee.find(params[:land_fee_id])
    land_fee_payments = land_fee.land_fee_payments.new(
      payment: params[:payment],
      pay_date: params[:pay_date],
      comment: params[:comment],
      currency_id: params[:currency_id],
      tomado_en: params[:tomado_en],
      total: params[:calculo_en_pesos],
      pay_name: params[:name_pay]
    )
    if !params[:images].nil?
      land_fee_payments.images = params[:images]
    end

    respond_to do |format|
      # create tiene un callback para actualizar land_fee
      if land_fee_payments.save!
        format.json { render json: {'status' => 'success', 'msg' => 'Pago registrado'}, location: @land_fee_payment }
      else
        format.json { render json: land_fee.land_fee_payments.errors, status: :unprocessable_entity }
      end
    end
    
    rescue => e
      puts "!!! rescue => #{e}"
      response = e.message.split(':')
      puts "===> #{response[1]}"
      response[1] = response[1].split(' ')[1..-1].join(' ')
      render json: { response[0] => response[1] }, status: 402
  end

  # PATCH/PUT /land_fee_payments/1 or /land_fee_payments/1.json
  def update
    respond_to do |format|
      if @land_fee_payment.update(land_fee_payment_params)
        format.html { redirect_to @land_fee_payment, notice: "Land fee payment was successfully updated." }
        format.json { render :show, status: :ok, location: @land_fee_payment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @land_fee_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @land_fee_payment.destroy
    respond_to do |format|
      format.html { redirect_to land_fee_payments_url, notice: "Land fee payment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_land_fee_payment
      @land_fee_payment = LandFeePayment.find(params[:id])
    end

    def land_fee_payment_params
      params.require(:land_fee_payment).permit(:payment, :pay_date, :images, :comment, :currency_id, :tomado_en,:active, :total, :pay_name)
    end
end
