require('nez').realize 'NoticeClient', (NoticeClient, test, context, should, notice) -> 



    context 'notice', (it) ->

        it 'was injected', (done) -> 

            notice.configure.should.be.an.instanceof Function
            test done



    context 'configure', (it) -> 

        it 'configures the notifier with a messenger', (done) -> 

            notice.configure

                source: 'test'
                messenger: (msg) -> test done

            notice 'message'


    context 'an async configure', (it) -> 

        it 'would be better', (because) -> 

            because 'it allows for connecting to a messaging hub',    (done) -> test done
            because 'it could collect the messenger config remotely', (done) -> test done
            because 'it could be a messenger "factory"',              (done) -> test done

        





