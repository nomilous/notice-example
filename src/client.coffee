{CapsuleEmitter} = require './client/capsule_emitter'
{memoryUsage} = process

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

        ticks: 
            health: 
                interval: 1000
            # tick2: 
            #     interval: 5000
            # tick3: 
            #     interval: 10000

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
                title: 'put in a hidden timestamp'
                (next, capsule, traversal) -> 
                    capsule.$$set
                        timestamp: new Date
                        hidden: true
                        protected: true

                    next()

            emitter.use
                title: 'show ticks'
                (next, capsule, traversal) ->


                    if capsule.$$tick == 'health'

                        console.log capsule if capsule.$$tick?

                        {rss, heapTotal, heapUsed} = memoryUsage()
                        rss = Math.floor(rss / 1024 / 1024 * 100) / 100
                        heapTotal = Math.floor(heapTotal / 1024 / 1024 * 100) / 100
                        heapUsed = Math.floor(heapUsed / 1024 / 1024 * 100) / 100

                        emitter.health 'process memory', 
                            rss: rss
                            heap:
                                total: heapTotal
                                used:  heapUsed

                    next()


            setInterval (->

                emitter.request 'text', more: 'stuff'

            ), 1000

            # ), 1
            # 
            # watch -n1 curl -su user: :20002/v1/hubs/1/cache/result
            # 
            # watch -n1 curl -su user: :20002/v1/hubs/1/tools/elastic/stats
            # 
                                    #           
                                    # dinkum throttling to 10 concurrent requests into elastic
                                    # 

            # curl -su user: :20002/v1/hubs
            # {
            #   "records": [
            #     {
            #       "title": "Message Bus Title",
            #       "uuid": 1,
            #       "metrics": {
            #         "pipeline": {
            #           "input": {
            #             "count": 170597
            #           },
            #           "processing": {
            #             "count": 49379    <------------ the resulting backlog in the hubs middleware pipeline
            #                                             
            #                                             # TODO: find the wedge, stopped the inbound, 
            #                                                     this never reached 0
            #                                                     a stray exit case... (_grumbles_)
            #           },
            #           "output": {
            #             "count": 121215
            #           },
            #           "error": {
            #             "usr": 0,
            #             "sys": 0
            #           },
            #           "cancel": {
            #             "usr": 3,
            #             "sys": 0
            #           }
            #         }
            #       }
            #     }
            #   ]
            # }
            # 


            callback null, emitter
