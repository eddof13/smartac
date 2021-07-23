class SensorDataController < ApplicationController
    protect_from_forgery unless: -> { request.format.json? || request.format.xml? }
    before_action :validate_auth, only: [:create]
    
    def create
        sensor_data = SensorDatum.create!(sensor_data_params)
        render json: sensor_data_params, status: :created
    end

    private

    def validate_auth
        auth_token = request.headers['Authorization']
        auth_token = auth_token.split(' ').last if auth_token&.starts_with?('Bearer ')
        device = Device.find(params['device_id'])
        unless ::AuthService.new.validate(device.serial_number, auth_token)
            render json: { error: "Invalid auth token for device" }, status: 401
        end
    end

    def sensor_data_params
        filtered_params = params.permit(:temperature, :humidity_percentage, :co_level, :health_status, :device_id, :collection_date, :_json => [:temperature, :humidity_percentage, :co_level, :health_status, :device_id, :collection_date])
        if filtered_params.key?('_json')
            filtered_params['_json'].map {|val| val.merge(device_id: params['device_id']) }
        else
            filtered_params
        end
    end
end
