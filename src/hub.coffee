








{MessageBus} = require './server/message_bus'

exports.start = (callback) -> 
    
    MessageBus.create 

        title: 'Message Bus Title'
        uuid: 1
        listen: 
            adaptor: 'socket.io'
            port:     10001

        (error, hub) -> 

            return callback error if error?








            hub.use

                title: 'initializer'
                description: """
                First middleware is usefull for filtering builtin control capsules.
                """

                (next, capsule, traveral) -> 

                    return next.cancel() if capsule.$$control?
                    next()







            hub.use

                title: 'hot swap slot'
                description: """
                Second middleware to play with.
                """

                (next, capsule, traversal) -> 

                    #
                    # do nothing, for now
                    #

                    next()








