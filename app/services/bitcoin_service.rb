require 'rest-client'
require 'json'

class BitcoinService
  def initialize(amount)
    @amount = amount.to_f
  end

 
  def perform
    begin
      url = 'https://www.mercadobitcoin.net/api/BTC/ticker/' 
      res = RestClient.get url
      value = JSON.parse(res.body)['ticker']['last'].to_f
      
      value * @amount
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
  end
end