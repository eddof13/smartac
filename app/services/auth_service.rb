class AuthService
    # TODO: un-mock this
    DEVICES = {
        '1' =>'abc123',
        '2' => '123abc',
        '3' => 'hello',
        '4' => 'world',
        '5' => 'eddie',
        '6' => 'jesinsky',
        '7' => '123456',
        '8' => '78910',
        '9' => '000000',
        '10' => '111111'
    }.with_indifferent_access

    def register(serial_number, shared_secret)
        return nil unless DEVICES.key?(serial_number) && DEVICES[serial_number] == shared_secret

        { auth_token: encode(serial_number, shared_secret) }
    end

    def validate(serial_number, auth_token)
        payload = decode(auth_token).first
        serial_number == payload['serial_number'] && DEVICES[serial_number] == payload['shared_secret']
    rescue
        false
    end

    private

    def encode(serial_number, shared_secret)
        payload = { serial_number: serial_number, shared_secret: shared_secret }
        JWT.encode(payload, nil, 'none')
    end

    def decode(auth_token)
        JWT.decode(auth_token, nil, false)
    end
end
