{CapsuleEmitter} = require './client/capsule_emitter'

exports.start = (callback) -> 
    
    CapsuleEmitter.create

        title: 'Capsule Emitter'
        uuid:   2

        context: 
            this: 'is sent to the hub at handshake'
            and:  'is available alongside each capsule traversal'
            that: 'originated from this client'

        cache:
            this: 'is kept on the client side'
            and:  'is available alongside local traversals'


        connect:
            secret:             '∆'
            adaptor:            'socket.io'
            url:                'http://localhost:10001'
            #url:                'https://localhost:10001'
            errorWait:          1000
            rejectUnauthorized: false

        (error, emitter) -> 

            return callback error if error?

            emitter.use
                title: 'put in a hidden control code'
                (next, capsule, traversal) -> 
                    capsule.$$set
                        controlCode: 'XIIMVXVMIIX'
                        #hidden: false
                        hidden: true
                        protected: true

                    next()


            setInterval (->

                emitter.request 'text', more: 'stuff'

            ), 1000

            callback null, emitter
