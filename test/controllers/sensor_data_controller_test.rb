require 'test_helper'

class SensorDataControllerTest < ActionDispatch::IntegrationTest
  def test_send_data
    post '/devices', params: { serial_number: "1", firmware_version: "1", shared_secret: "abc123" }
    device_id = JSON.parse(response.body)['id']
    post "/devices/#{device_id}/sensor_data", headers: { 'Authorization' => 'Bearer eyJhbGciOiJub25lIn0.eyJzZXJpYWxfbnVtYmVyIjoiMSIsInNoYXJlZF9zZWNyZXQiOiJhYmMxMjMifQ.' }, params: { temperature: "29.31", humidity_percentage: "18.23", co2_level: "10.23", health_status: "ok", collection_date: "2021-07-21T15:25:54Z" }
    assert_equal JSON.parse(response.body)['health_status'], 'ok'
  end
end
