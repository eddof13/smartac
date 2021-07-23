# README

Welcome to the Smart AC prototype.

* Ruby version
`2.7`

* Rails version
`6.0`

#### In addition to rails default install, the prototype uses
- `gem 'clearance'` - user authentication
- `gem 'jwt'` - device identification
- `gem 'chartkick'` - graphs
- `gem 'groupdate'` - model queries extension for graphs
- `gem 'noticed'` - notifications

#### How to run the test suite
```
rails test
```

#### How to run the server locally
```
rails s
```

### How to create a device
- Send a POST request to /devices
- The shared secret and serial number must be a registered match (hardcoded in this POC- see in smartac/app/services/auth_service.rb)
```
curl --location --request POST 'localhost:3000/devices' \
--header 'Content-Type: application/json' \
--data-raw '{ 
        "serial_number": "1",
        "firmware_version": "1",
        "shared_secret": "abc123"
}'
```

Example response
```
{"serial_number":"1","firmware_version":"1","auth_token":"eyJhbGciOiJub25lIn0.eyJzZXJpYWxfbnVtYmVyIjoiMSIsInNoYXJlZF9zZWNyZXQiOiJhYmMxMjMifQ.","id":1}
```

### How to post a sensor data entry
- Send a POST request to /devices/{id}/sensor_data
- {id} is returned in the response from creating the device
- The Authorization header must be populated with the Bearer {auth_token}
- {auth_token} is also returned in the response from creating/registering the device
- The JSON body can be a single hash entry, or a JSON array of 1 or more entries
```
curl --location --request POST 'localhost:3000/devices/1/sensor_data' \
--header 'Authorization: Bearer eyJhbGciOiJub25lIn0.eyJzZXJpYWxfbnVtYmVyIjoiMSIsInNoYXJlZF9zZWNyZXQiOiJhYmMxMjMifQ.' \
--header 'Content-Type: application/json' \
--data-raw '[{ 
        "temperature": "29.31",
        "humidity_percentage": "18.23",
        "co_level": "8.23",
        "health_status": "needs_service",
        "collection_date": "2021-07-23T15:25:54Z"
}]'
```

Example response
```
[
    {
        "temperature": "29.31",
        "humidity_percentage": "18.23",
        "co_level": "8.23",
        "health_status": "needs_service",
        "collection_date": "2021-07-23T15:25:54Z",
        "device_id": "1"
    }
]
```

### Caveats in this POC
- We don't validate the range of values beyond their type, so co_level can be negative for example
- UI is mostly placeholder and not polished for the prototype
- Devices can only have one sensor
- Graphs are simple and are not user configurable (max value per minute for day, max per day for week+)
- Notifications require a page refresh to see, (login/logout notifications also show up with non-functional close button)
- Tests are limited to a couple integration tests
- Multiple sensor data entries are supported, right now we don't have a max enforced, however it's using ActiveRecord.create! for multiple entries, so not performant when 500 entries for example- would either move to insert_all to skip validations, or offload the batch entries to async process
- Calls are not idempotent, so entries with the same time will be accepted
- No delete, update, etc on device or sensor data
- Device registration is hardcoded to a select few, see note above
- No search
- In a real app I would probably separate the concerns a bit more - the devices API would also provide the retrieval endpoints, and the admin panel would retrieve using those API endpoints instead of server side Rails calls