{MessageBus} = require './server/message_bus'
{Client}     = require 'dinkum'
{tools}      = require 'notice' # ...literally amuzing, ...figuratively notable

exports.start = (callback) -> 
    
    MessageBus.create 

        title: 'Message Bus Title'
        uuid:  1

        listen: 
            secret:  '∆'
            adaptor: 'socket.io'
            port:     10001

            # 
            # cert: __dirname + '/../../cert/develop-cert.pem'
            # key:  __dirname + '/../../cert/develop-key.pem'
            # probably better for nginx to do this
            #


        ticks: one: {}
        cache: {}


        #
        # API: curl -u user: :20002/hubs/1/tools
        # -----------------------------------------
        # 
        # ### Purpose
        # 
        # * Exposes whatever a serialization of the tool instance returns onto the API.
        # * Solves the scope problem for the particular case of tools required by middleware
        # * Useful for remote monitoring of the tools
        # 

        tools:

            #
            # API: curl -u user: :20002/hubs/1/tools/class
            # -------------------------------------------------------
            # 
            # * An class example to illustrate $$notice api.
            # * curl -su user: :20002/hubs/1/tools/class/apiProperty
            # * curl -su user: :20002/hubs/1/tools/class/apiFunction
            #

            class: new tools.NoticeableClass
            #closure: tools.NoticeableClosure.create()


        (error, hub) -> 

            return callback error if error?

            # # 
            # # * hidden properties on the capsule will not be included
            # # * capsule.$$set propertyName: 'value', hidden: true, protected: true
            # # * capsule.$$all
            # # * not listed by capsule.$$all
            # #       * capsule.$$uuid
            # #       * capsule.$$hidden
            # #       * capsule.$$protected 
            # # 

            hub.use title: 'test', (next, capsule, traversal) -> 

                console.log capsule.$$all
                next()

            callback null, hub








