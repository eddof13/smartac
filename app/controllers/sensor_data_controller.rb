class SensorDataController < ApplicationController
    protect_from_forgery unless: -> { request.format.json? || request.format.xml? }
    
    def create
        sensor_data = SensorDatum.create!(sensor_data_params)
        # TODO: handle array of params

        if ::AuthService.new.validate(sensor_data.device.serial_number, params[:auth_token])
            response = sensor_data_params
            status = :created
        else
            response = { error: "Invalid auth token for device" }
            status = 401
        end

        render json: response, status: status
    end

    private

    def sensor_data_params
        params.permit(:temperature, :humidity_percentage, :co2_level, :health_status, :device_id)
    end
end
