require 'httparty'
require 'json'

require 'bigdecimal'
require 'bigdecimal/util'
class TickerController < ApplicationController

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
            @dlistUSD = data["data"].map { |obj| obj["quote"]["USD"]["price"] }
            @dlistBTC = data["data"].map { |obj| obj["quote"]["USD"]["price"].to_d/(@btcprice)}
            @dlistETH = data["data"].map { |obj| obj["quote"]["USD"]["price"].to_d/(@ethprice)}

            @status = data["status"]["timestamp"]
            
    
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