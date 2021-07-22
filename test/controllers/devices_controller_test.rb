require 'test_helper'

class DevicesControllerTest < ActionDispatch::IntegrationTest
  def test_registration
    post '/devices', params: { serial_number: "1", firmware_version: "1", shared_secret: "abc123" }
    assert_equal JSON.parse(response.body)['auth_token'], 'eyJhbGciOiJub25lIn0.eyJzZXJpYWxfbnVtYmVyIjoiMSIsInNoYXJlZF9zZWNyZXQiOiJhYmMxMjMifQ.'
  end
end
