module.exports.MessageBus = require('notice').hub
    
    manager: 
        # authenticate: 
        #     username: 'admin'
        #     password: ''
        authenticate: (username, password, callback) -> callback null, true
        listen: 
            port: 20002
            # 
            # cert: __dirname + '/../../cert/develop-cert.pem'
            # key:  __dirname + '/../../cert/develop-key.pem'
            # probably better for nginx to do this
            # 

    error:
        keep: 100

