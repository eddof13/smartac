class SensorDataController < ApplicationController
    protect_from_forgery unless: -> { request.format.json? || request.format.xml? }
    
    def create
        render json: { hello: 'world' }
    end
end
