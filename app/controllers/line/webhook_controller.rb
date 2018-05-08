class Line::WebhookController < ApplicationController
  protect_from_forgery except: [:callback]

  def callback
    body = request.body.read
    events = client.parse_events_from(body)

    events.each do |event|
      case event['type']
      when 'follow'
        Line::LinkUnconnectedRichmenuService.new(event['source']['userId']).link
      when 'unfollow'
        Line::DestroyConnectionService.new(event['replyToken'], event['source']['userId']).destroy
        Line::UnlinkRichmenuService.new(event['source']['userId']).unlink
      when 'postback'
        case event['postback']['data']
        when 'connected'
          Line::CreateLinkTokenService.new(event['replyToken'], event['source']['userId']).create
        when 'disconnected'
          Line::ConfirmDestroyableConnectionService.new(event['replyToken']).confirm
        when 'destroy_connection[OK]'
          Line::DestroyConnectionService.new(event['replyToken'], event['source']['userId']).destroy
          Line::LinkUnconnectedRichmenuService.new(event['source']['userId']).link
        when 'destroy_connection[NG]'
          Line::CancelDestroyedConnectionService.new(event['replyToken']).cancel
        when 'shift_submission'
          Line::ReplyStartTimeSelectService.new(event['replyToken'], event['source']['userId']).reply
        when 'shift_submission[start_time]'
          Line::ReplyEndTimeSelectService.new(event['replyToken'], event['source']['userId'], event['postback']['params']['datetime']).reply
        when 'shift_submission[end_time]'
          Line::ConfirmShiftSubmissionService.new(event['replyToken'], event['source']['userId'], event['postback']['params']['datetime']).confirm
        when 'shift_submission[regist]'
          Line::RegistShiftSubmissionService.new(event['replyToken'], event['source']['userId']).regist
        when 'shift_submission[cancel]'
          Line::CancelShiftSubmissionService.new(event['replyToken'], event['source']['userId']).cancel
        end
      when 'accountLink'
        case event['link']['result']
        when 'ok'
          Line::CreateConnectionService.new(event['source']['userId'], event['link']['nonce']).create
          Line::LinkConnectedRichmenuService.new(event['replyToken'], event['source']['userId']).link
        end
      end
      case event
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
