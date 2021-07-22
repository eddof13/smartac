class AdminController < ApplicationController
    before_action :require_login
    before_action :check_notifications

    def index
        @devices = Device.all
    end

    def show
        @device = Device.find(params[:device_id])

        @sensor_data_today = sensor_data_minute(@device, Time.now.beginning_of_day..Time.now)
        @sensor_data_week = sensor_data_day(@device, (Time.now-1.week)..Time.now)
        @sensor_data_month = sensor_data_day(@device, (Time.now-1.month)..Time.now)
        @sensor_data_year = sensor_data_day(@device, (Time.now-1.year)..Time.now)
    end

    def clear_notices
        current_user.notifications.unread.mark_as_read!
        redirect_to root_path
    end

    private

    def check_notifications
        current_user.notifications.unread.each do |notification|
            flash.now[:alert] = notification.params[:message]
        end
    end

    def sensor_data_day(device, range)
        device.sensor_datum.group_by_day(:collection_date, range: range)
    end

    def sensor_data_minute(device, range)
        device.sensor_datum.group_by_minute(:collection_date, range: range)
    end
end
