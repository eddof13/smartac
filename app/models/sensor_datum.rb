require 'validators/sensor_validator'

class SensorDatum < ApplicationRecord
    belongs_to :device

    validates_with SensorValidator
end
