require('nez').realize 'Emitter', (Emitter, test, it) -> 

    it 'assembles stats down a messenger pipeline', (done) ->

        Emitter.stats()
        test done
