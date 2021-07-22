class DevicesController < ApplicationController
    protect_from_forgery unless: -> { request.format.json? || request.format.xml? }
    
    def create
        device = Device.create!(device_params)
        registration = ::AuthService.new.register(device.serial_number, params[:shared_secret])
        if registration
            response = device_params.merge(auth_token: registration[:auth_token], id: device.id)
            status = :created
        else
            response = { error: "Invalid registration" }
            status = 401
        end

        render json: response, status: status
    end

    private

    def device_params
        params.permit(:serial_number, :firmware_version)
    end
end
