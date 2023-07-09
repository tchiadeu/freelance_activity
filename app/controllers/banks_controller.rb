class BanksController < ApplicationController
  def new
    @bank = Bank.new
  end

  def create
    @bank = Bank.new(bank_params)
    @bank.user = current_user
    if @bank.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @bank = Bank.find(params[:id])
  end

  def update
    @bank = Bank.find(params[:id])
    @bank.update(bank_params)
  end

  def destroy
    @bank = Bank.find(params[:id])
    @bank.destroy
  end

  private

  def bank_params
    params.require(:bank).permit(:name, :iban_number, :bic_number)
  end
end
