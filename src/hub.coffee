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

        ticks: TEST: {}

        cache: 

            #
            # API: curl -u user: :20002/v1/hubs/1/cache
            # -----------------------------------------
            # 
            # ### Purpose
            # 
            # * Provides a dynamic caching space accessable to middleware via traversal.cache
            # * Solves the problem of hotswapped middleware not having access to a surrounding scope
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
            #   * The thing that does the drilling will require a ` way ` to recognize the lazy 
            #     persisted component and asynchronize accordingly. 
            # 
            #     https://github.com/nomilous/notice/blob/master/src/management/manager.coffee#L156
            #     or thereabouts ('/v1/hubs/:uuid:/cache/**/*')
            # 
            #   * I have suggested lazyloading because the cache could get quite big and the overhead
            #     when fetching it ahead of each capsule traversal would counter produce.
            # 
            #   * Also, now exceedingly pleased i did this waffling, it birthed me a steamingly fresh epiphany.
            # 
            #         * A `Noticeability` API
            #         * Examples below
            #         * Still in swaddling tho
            #  

            'preloaded-key': {}

        tools:

            #
            # API: curl -u user: :20002/v1/hubs/1/tools
            # -----------------------------------------
            # 
            # ### Purpose
            # 
            # * Exposes whatever a serialization of the tool instance returns onto the API.
            # * Solves the scope problem for the particular case of tools required by middleware
            # * Useful for remote monitoring of the tools
            # 



            #
            # GOOD: watch curl -su user: :20002/v1/hubs/1/tools/elastic/stats
            # BAD:  watch curl -su user: :20002/v1/hubs/1/tools/elastic
            # GOOD: watch curl -su user: :20002/v1/hubs/1/tools
            #



            elastic: Client.create

                #
                # API: curl -u user: :20002/v1/hubs/1/tools/elastic
                # -------------------------------------------------
                # 
                # * Provides a configured instance of dinkum http(s) client assigned to
                #   interface with the elasticsearch instance running on the localhost.
                # 
                # * Available to the middleware at traversal.tools.elastic
                # 
                # * Note - This will not fail if elastic is not running, that failure 
                #          occurs when attempting to use the interface.
                # 
                
                transport: 'http'
                port: 9200


            class: 

                #
                # API: curl -u user: :20002/v1/hubs/1/tools/class
                # -------------------------------------------------------
                # 
                # * An class example to illustrate $$notice api.
                # * curl -su user: :20002/v1/hubs/1/tools/class/apiProperty
                # * curl -su user: :20002/v1/hubs/1/tools/class/apiFunction
                #

                new tools.NoticeableClass


            'closure-example': 

                tools.NoticeableClosure.create()



        (error, hub) -> 

            return callback error if error?








            hub.use

                title: 'initializer'
                description: """
                First middleware is usefull for filtering builtin control capsules.
                """

                (next, capsule, traveral) -> 

                    console.log capsule if capsule.$$tick?

                    return next.cancel() if capsule.$$control?
                    next()




            hub.use 

                title: 'client health'
                (next, capsule, {origin, tools}) -> 

                    return next() unless capsule.health?

                    tools.elastic.post

                        path: '/test-database/health'
                        'application/json':

                            hostname: origin.context.hostname
                            timestamp: capsule.timestamp
                            memory: capsule     # timestamp is hidden so this serialization
                                                # does not result in memory.timestamp nesting

                    .then (r) -> console.log r
                        
                    next()





            hub.use title: 'testing things', (next, capsule, {tools}) -> 

                #console.log tools['class-example']
                #console.log tools.elastic
                next()



            hub.use

                title: 'example'
                description: """
                A second middleware to play with.
                """

                (next, capsule, {tools, cache}) -> 



                    # #
                    # # insert the capsule (as-is) into elastic
                    # # ---------------------------------------
                    # # 
                    # # * hidden properties on the capsule will not be included
                    # # * capsule.$$set propertyName: 'value', hidden: true, protected: true
                    # # * capsule.$$all
                    # # * not listed by capsule.$$all
                    # #       * capsule.$$uuid
                    # #       * capsule.$$hidden
                    # #       * capsule.$$protected 
                    # # 

                    # tools.elastic.put 

                    #     path: '/test-database/test-table/id'
                    #     'application/json': capsule
                    #     #'application/json': capsule.$$all

                    #     #
                    #     # ask elastic for it
                    #     # ------------------
                    #     # 
                    #     # curl -s :9200/test-database/test-table/id | json
                    #     #


                    # .then (result) -> 


                    #     #
                    #     # store the response from elastic in the cache
                    #     # --------------------------------------------
                    #     # 
                    #     # curl -u user: :20002/v1/hubs/1/cache/result
                    #     #

                    #     cache.result = result
                    next()



            callback null, hub








