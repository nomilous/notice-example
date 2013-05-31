
os             = require 'os'
notice         = require('notice').create 'example message generator'
module.exports = stats: -> notice.info.normal 'status update'




#
# middleware - augment messages with platform details
#
notice.use (payload, next) -> 
    payload.platform ||= {}
    payload.platform[ fName ] = os[ fName ]() for fName in [

        'hostname'
        'type'
        'platform'
        'arch'
        'release' 

    ]
    next()


#
# middleware - augment messages with platform specs
# 
notice.use (payload, next) -> 
    payload.specs ||= {}
    payload.specs[ fName ] = os[ fName ]() for fName in [

        'cpus'
        'totalmem'
        'networkInterfaces'

    ]
    next()


#
# middleware - augment messages with platform metrics
# 
notice.use (payload, next) -> 
    payload.stats ||= {}
    payload.stats[ fName ] = os[ fName ]() for fName in [

        'loadavg'
        'uptime'
        'freemem'

    ]
    next()


#
# middleware - display message as JSON
# 
notice.use (msg, next) -> 
    #console.log JSON.stringify msg.content, null, 2
    console.log JSON.stringify msg.content
    next()


     

