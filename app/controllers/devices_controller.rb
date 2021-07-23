class DevicesController < ApplicationController
    protect_from_forgery unless: -> { request.format.json? || request.format.xml? }
    before_action :validate_registration, only: [:create]

    def create
        device = Device.create!(device_params)
        response = device_params.merge(auth_token: registration[:auth_token], id: device.id)

        render json: response, status: :created
    end

    private

    def validate_registration
        unless registration
            render json: { error: "Invalid registration" }, status: 401
        end
    end

    def registration
        @registration ||= ::AuthService.new.register(params[:serial_number], params[:shared_secret])
    end

    def device_params
        params.permit(:serial_number, :firmware_version)
    end
end
