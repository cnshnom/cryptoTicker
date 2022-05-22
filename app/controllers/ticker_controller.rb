require 'httparty'
require 'json'

require 'bigdecimal'
require 'bigdecimal/util'
class TickerController < ApplicationController

    def get_price(price_float)
        price_string = '%.10f' % price_float
        price = price_string.to_i
        digits = price_string.to_s.split('.')[1]
        # get all digits until you have at least two significant ones (>0)
        arraydigit = digits.chars
        count = 0
        found = false
        length = arraydigit.length
        for idx in 0...arraydigit.length
            if(arraydigit[idx]!='0')
                count = count + 1
            end
            if(count == 2)
                length = idx+1
                break
            end
        end
        delimiter = "."
        price = price.to_s
        digits = digits[0,length].to_s
        final = price +delimiter+ digits
        return final
    end

    def home
        results = HTTParty.get("https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?limit=50",
            :headers =>{
                "X-CMC_PRO_API_KEY" => "d0eea4e6-b070-4e1b-85e4-93b14d94e76f",
                "Content-Type" => "application/json"
            }
            )
            @message = results
            data = JSON.parse(results&.body)
            @btcprice = data["data"][0]["quote"]["USD"]["price"].to_d            
            @ethprice = data["data"][1]["quote"]["USD"]["price"]
            @dlistsymbol = data["data"].map { |obj| obj["symbol"] }
            @dlistUSD = data["data"].map { |obj| get_price(obj["quote"]["USD"]["price"]) }
            @dlistBTC = data["data"].map { |obj| get_price(obj["quote"]["USD"]["price"].to_d/(@btcprice))}
            @dlistETH = data["data"].map { |obj| get_price(obj["quote"]["USD"]["price"].to_d/(@ethprice))}

            @status = Time.now().strftime("%d.%m.%Y  %H:%M:%S")
    
    end



    def eth     
        
        results = HTTParty.get("https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?limit=2&price_max=10000",
        :headers =>{
            "X-CMC_PRO_API_KEY" => "d0eea4e6-b070-4e1b-85e4-93b14d94e76f",
            "Content-Type" => "application/json"
        }
        )
        @message = results
    end

    def btc
        results = HTTParty.get("https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?limit=2&price_min=10000",
            :headers =>{
                "X-CMC_PRO_API_KEY" => "d0eea4e6-b070-4e1b-85e4-93b14d94e76f",
                "Content-Type" => "application/json"
            }
        )
        data = JSON.parse(results&.body)
        price = data["data"][0]["quote"]["USD"]["price"]
        @message = price
    end
end