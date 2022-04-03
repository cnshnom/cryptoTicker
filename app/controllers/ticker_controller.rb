require 'httparty'

class TickerController < ApplicationController
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
            @message = results
    end
end