@Stations = new Meteor.Collection 'stations'

refreshFromMARTA = ->
  res = HTTP.get "http://developer.itsmarta.com/RealtimeTrain/RestServiceNextTrain/GetRealtimeArrivals?apikey=#{share.api_key_MARTA}"
  if res.statusCode isnt 200
    return console.log "Failed to get realtime train information",res
  if not _.isArray res.data
    return console.log "Failed to get meaningful realtime train information",res
  stations = _.uniq(_.pluck(res.data,'STATION')).sort()
  _.each stations,(i)->
    Stations.update {
      name: i
    },{ $set: { name: i } },{ upsert: true }

if Meteor.isServer
  # Periodically update the station list
  stationInterval = null
  Meteor.startup ->
    refreshFromMARTA()
    stationInterval = Meteor.setInterval refreshFromMARTA,60000

