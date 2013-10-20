{MessageBus} = require './server/message_bus'

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

        cache: 

            #
            # API: curl -u user: :20002/v1/hubs/1/cache
            # -----------------------------------------
            # 
            # ### Purpose
            # 
            # * Provides a dynamic caching space accessable to middleware via traversal.cache
            # * The same cache instance is passed into ALL traversals
            # * Visible over the api, making it ultra useful as an integration vector
            # 
            # * DOES NOT PERSIST (restart the hub and it's gone...)
            # 
            # ### Possibilities
            # 
            #   * I made the following suggestion without considering the obvious diffiulty
            #     presented by the asynchronousity required for persisting. It cannot be 
            #     be done `as suggested`. 
            # 
            #   # * A middleware can be placed early in the pipeline to persist it.
            #   # * How and to where is entirely up to the middleware.
            #   # * Guidelines
            #   # 
            #   #      * Use the hub uuid.
            #   #      * Remember, it should be global, retreiving from persistance per
            #   #        traversal.origin (which client is this capsule from) will lead
            #   #        to problems when attempting to view the cache from the api without
            #   #        a client context
            #   #      * Load origin specific stuff onto the capsule.origin object instead.
            #   #      * `cache.  persistedComponents  .lazyLoadedObject` sounds like a good idea,
            #   #        an Object.defineProperty() could probably configure the lasyload
            #   #        to get the record from some db.
            #   #      * This would be especially useful because of the fact that the API
            #   #        can drill into the cache. 
            #   #  
            #   #        ie.  /v1/hubs/1/cache/persistedComponent/lazyLoadedObject/someThingInIt
            #   # 
            #   #        (i ""think"" the mech that does the drilling will not disturb the neigh- 
            #   #           bours on the way down, if not, something will need to be ""done"")
            #   # 
            #   #      * Also in the works (for some unknown future release) is the ability to
            #   #        PUT/POST objects into the cache via the API, that obviously has sizeable
            #   #        implications for this persistor.
            #   # 
            #   #      * A last middleware could do the saving of any changes.
            #   #      * Or lazySave, if you know what i mean, this might be tricky
            #   #      * If anybody pulls this off i would love to see it / maybe incorperate it 
            #   #  
            # 
            #   * The thing that does the drilling will require a `way` to recognize the lazy 
            #     persisted component and asynchronize accordingly. 
            # 
            #     https://github.com/nomilous/notice/blob/master/src/management/manager.coffee#L156
            #     or thereabouts ('/v1/hubs/:uuid:/cache/**/*')
            # 

            'preloaded-key': {}

        tools:

            #
            # API: curl -u user: :20002/v1/hubs/1/tools
            #

            'tool-instance': {}



        (error, hub) -> 

            return callback error if error?








            hub.use

                title: 'initializer'
                description: """
                First middleware is usefull for filtering builtin control capsules.
                """

                (next, capsule, traveral) -> 


                    # capsule.controlCode = 'try to change it'
                    # console.log ALL: capsule.$$all
                    # console.log SERAILIZERS_SEE: capsule
                    # console.log UUID: capsule.$$uuid

                    return next.cancel() if capsule.$$control?
                    next()







            hub.use

                title: 'hot swap slot'
                description: """
                Second middleware to play with.
                """

                (next, capsule, traversal) -> 

                    console.log capsule

                    #
                    # do nothing, for now
                    #

                    next()








