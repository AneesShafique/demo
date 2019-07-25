App.comment = App.cable.subscriptions.create "CommentChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('#reviews').append "<h4>#{data.name}</h4>"
    $('#reviews').append "<p>#{data.comment}</p>"
    $('#reviews').append( "<a href='/products/#{data.pid}/reviews/#{data.cid}' data-method = delete rel = 'no-follow' >Delete</a><hr>")

