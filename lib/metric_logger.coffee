net = require('net')
module.exports = class MetricLogger
  constructor: (api_key) ->
    @api_key = api_key
    console.error "Missing Hosted Graphite API key" unless @api_key?
    @socket = net.createConnection(2003, 'carbon.hostedgraphite.com')

  log: (metric, value, cb) ->
    return cb?(new Error("Must provide metric and value")) unless metric? and value?
    @socket?.write "#{@api_key}.#{metric} #{value}\n"
