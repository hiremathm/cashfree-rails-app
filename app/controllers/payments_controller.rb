class PaymentsController < ApplicationController
  require 'net/http'

  skip_before_action :verify_authenticity_token, only: [:cfrequest, :cf_response, :home]

  def home
  	
  end

  def cfrequest
    init_resp = eval(params["input"])
    data = init_resp[:data][:signature_data]
    @postData = {
      "appId" => data[:appId],
      "orderId" => data[:orderId],
      "orderAmount" => data[:orderAmount],
      "orderCurrency" => data[:orderCurrency],
      "orderNote" => data[:orderNote],
      "customerName" => data[:customerName],
      "customerPhone" => data[:customerPhone],
      "customerEmail" => data[:customerEmail],
      "returnUrl" => data[:returnUrl],
      "notifyUrl" =>  data[:notifyUrl]
    }
    @url = init_resp[:data][:payment_url]
    @signature = init_resp[:data][:signature]
  end

  def cf_response
    @postData = {
    "orderId" => params[:'orderId'], 
    "orderAmount" => params[:'orderAmount'], 
    "referenceId" => params[:'referenceId'], 
    "txStatus" => params[:'txStatus'], 
    "paymentMode" => params[:'paymentMode'], 
    "txMsg" => params[:'txMsg'], 
    "txTime" => params[:'txTime']
    }
    # "1466f1c66c9e54a81774936e6641"
    @secretKey = "de86689e005c5104f441fd46b83ddcde2fbf1deb"
    @signature = params[:'signature']
    @signatureData = ""
    @postData.each do |key,value|
      @signatureData += value
    end
    @computedsignature = Base64.encode64(OpenSSL::HMAC.digest('sha256', @secretKey, @signatureData)).strip()
  end 
end
