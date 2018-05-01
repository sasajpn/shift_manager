class Line::WebhookController < ApplicationController
  protect_from_forgery except: [:callback]

  def callback
    body = request.body.read
    events = client.parse_events_from(body)

    events.each do |event|
      case event['type']
      when 'accountLink'
        case event['link']['result']
        when 'ok'
          if line_connection = LineConnection.find_by(nonce: event['link']['nonce'])
            line_connection.update(line_user_id: event['source']['userId'])
            Line::UpdateRichmenuService.new(line_connection).update
          end
        end
      end
      case event
      when Line::Bot::Event::Postback
        case event['postback']['data']
        when 'connected'
          link_token = Line::CreateLinkTokenService.new(event['source']['userId']).create
          message = {
            type: 'text',
            text: "https://567a3b2f.ngrok.io/admins/line_connections/new?linkToken=#{link_token}"
          }
          client.reply_message(event['replyToken'], message)
        end
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          message = {
            type: 'text',
            text: event.message['text']
          }
          client.reply_message(event['replyToken'], message)
        when Line::Bot::Event::MessageType::Image, Line::Bot::Event::MessageType::Video
          response = client.get_message_content(event.message['id'])
          tf = Tempfile.open("content")
          tf.write(response.body)
        end
      end
      "OK"
    end
  end
end
