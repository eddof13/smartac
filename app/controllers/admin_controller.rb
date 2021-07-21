class AdminController < ApplicationController
    before_action :require_login

    def index
        @devices = Device.all
    end

    def show
        @device = Device.find(params[:device_id])
    end
end
