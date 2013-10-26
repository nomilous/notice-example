module.exports.MessageBus = require('notice').hub

    # ticks: 
    #     master:
    #         interval: 1000
    
    manager: 
        # authenticate: 
        #     username: 'admin'
        #     password: ''
        authenticate: (username, password, callback) -> 
            # console.log AUTHENTICATE: u: username, p: password
            callback null, 
                username: username
                roles: ['admin']

            #
            # curl -u user: :20002/v1/hubs/1/tools/class/apiFunction
            #

        listen: 
            port: 20002
            # 
            # cert: __dirname + '/../../cert/develop-cert.pem'
            # key:  __dirname + '/../../cert/develop-key.pem'
            # probably better for nginx to do this
            # 

    error:
        keep: 100

