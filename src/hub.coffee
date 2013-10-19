{MessageBus} = require './server/message_bus'

exports.start = -> 
    
    MessageBus.create 

        title: 'Message Bus Title'
        uuid: 1

        (error, hub) -> 

            console.log hub

