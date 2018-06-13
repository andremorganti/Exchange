require 'rest-client'
require 'json'

class ExchangeService
  def initialize(source_currency, target_currency, amount)
    @source_currency = source_currency
    @target_currency = target_currency
    @amount = amount.to_f
  end

 
  def perform
    begin
      if @source_currency != 'BTC' and @target_currency != 'BTC'
        exchange_api_url = Rails.application.credentials[Rails.env.to_sym][:currency_api_url]
        exchange_api_key = Rails.application.credentials[Rails.env.to_sym][:currency_api_key]
        url = "#{exchange_api_url}?token=#{exchange_api_key}&currency=#{@source_currency}/#{@target_currency}"
        res = RestClient.get url
        value = JSON.parse(res.body)['currency'][0]['value'].to_f
      
        value * @amount
      else
        if @source_currency != 'BTC'
          cur_base = @source_currency
        elsif @target_currency != 'BTC'
          cur_base = @target_currency
        end
        puts cur_base
        url_base = "https://api.coindesk.com/v1/bpi/currentprice/#{cur_base}.json"
        res = RestClient.get url_base
        value = JSON.parse(res.body)['bpi'][cur_base]['rate_float']

        if @source_currency == 'BTC'
          value * @amount
        else
          @amount / value
        end
      end
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
  end
end