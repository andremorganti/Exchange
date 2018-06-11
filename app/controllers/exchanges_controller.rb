class ExchangesController < ApplicationController
  def index
  end

  def convert
    #api para enviar o form para conversão e devolver o json para ser capturado pelo
    #ajax e informar no campo result
    #teste deploy
    value = ExchangeService.new(params[:source_currency], params[:target_currency], params[:amount]).perform
    render json: {"value": value}
  end
end