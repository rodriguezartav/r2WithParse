Spine = require("rspine")


class RealtimeManager

  constructor: () ->
    LazyLoad.js "http://js.pusher.com/1.12/pusher.min.js", =>
      @keys = Spine.options.pusher.keys
      Pusher.channel_auth_endpoint = @keys.authUrl
      @pusher = new Pusher  @keys.restKey 
      @subscribeToChannels @defaultChannels()
      Spine.trigger "plataform:pusher_loaded"

  defaultChannels: =>
    channels = ["salesforce-realtime-push"]
    if Spine.session
      channels.push "presence-user"
    else
      channels.push "platform_users"
    channels

  registerForChat: =>
    

  subscribeToChannels: (channels) =>
    channels = @keys.channels if !channels
    if channels then @pusher.subscribe(channel) for channel in channels

  trigger: (channel , ev , data) =>
    @pusher.channel(channel).trigger ev data

  bind: (channel , ev , callback) =>
    @pusher.channel(channel).bind ev , callback

module.exports = RealtimeManager