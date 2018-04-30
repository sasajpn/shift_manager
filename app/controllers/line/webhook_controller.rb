class Line::WebhookController < ApplicationController
  protect_from_forgery except: [:callback]

  def callback
    body = request.body.read
    events = client.parse_events_from(body)

    events.each do |event|
      case event.message['text']
      when '連携'
        message = {
          type: 'text',
          text: 'OK!'
        }
        client.reply_message(event['replyToken'], message)
      end
      "OK"
    end
  end
end
