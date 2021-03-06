// Generated by CoffeeScript 1.6.3
module.exports.MessageBus = require('notice').hub({
  api: {
    authenticate: function(username, password, callback) {
      return callback(null, {
        username: username,
        roles: ['admin']
      });
    },
    listen: {
      port: 20002
    }
  },
  error: {
    keep: 100
  }
});
