module.exports = (db, ws, message)->
    cb = ->
    return cb null if message.type isnt \parity_unsignedTransactionsCount
    err, name <- db.get "ws/#{ws.id}"
    return cb err if err?
    err, data <- db.get \parity_unsignedTransactionsCount
    model = if err? then {} else data
    model[name] = message.message
    err <- db.put \parity_unsignedTransactionsCount , model
    return cb err if err?
    
    cb null
    
module.exports.poll = JSON.stringify { method: \parity_unsignedTransactionsCount }