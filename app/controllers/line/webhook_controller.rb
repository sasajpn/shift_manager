class Line::WebhookController < ApplicationController
  protect_from_forgery except: [:callback]

  def callback
    body = request.body.read
    events = client.parse_events_from(body)

    events.each do |event|
      case event['type']
      when 'follow'
        Line::Richmenus::LinkUnconnectedRichmenuService.new(
          line_user_id: event['source']['userId']
        ).link
      when 'unfollow'
        Line::Accounts::DestroyConnectionService.new(
          reply_token: event['replyToken'],
          line_user_id: event['source']['userId']
        ).destroy
        Line::Richmenus::UnlinkRichmenuService.new(
          line_user_id: event['source']['userId']
        ).unlink
      when 'postback'
        case event['postback']['data']
        when 'connected'
          Line::Accounts::CreateLinkTokenService.new(
            reply_token: event['replyToken'],
            line_user_id: event['source']['userId']
          ).create
        when 'disconnected'
          Line::Accounts::ConfirmDestroyableConnectionService.new(
            reply_token: event['replyToken']
          ).confirm
        when 'destroy_connection[OK]'
          Line::Accounts::DestroyConnectionService.new(
            reply_token: event['replyToken'],
            line_user_id: event['source']['userId']
          ).destroy
          Line::Richmenus::LinkUnconnectedRichmenuService.new(
            line_user_id: event['source']['userId']
          ).link
        when 'destroy_connection[NG]'
          Line::Accounts::CancelDestroyedConnectionService.new(
            reply_token: event['replyToken']
          ).cancel
        when 'shift_submission'
          Line::ShiftSubmissions::ReplyTeamSelectService.new(
            reply_token: event['replyToken'],
            line_user_id: event['source']['userId']
          ).reply
        when /shift_submission\[team\]/
          Line::ShiftSubmissions::ReplyStartTimeSelectService.new(
            reply_token: event['replyToken'],
            line_user_id: event['source']['userId'],
            team_id: event['postback']['data']&.split('=')[1]
          ).reply
        when 'shift_submission[start_time]'
          Line::ShiftSubmissions::ReplyEndTimeSelectService.new(
            reply_token: event['replyToken'],
            line_user_id: event['source']['userId'],
            start_time: event['postback']['params']['datetime']&.to_time
          ).reply
        when 'shift_submission[end_time]'
          Line::ShiftSubmissions::ConfirmShiftSubmissionService.new(
            reply_token: event['replyToken'],
            line_user_id: event['source']['userId'],
            end_time: event['postback']['params']['datetime']&.to_time
          ).confirm
        when 'shift_submission[regist]'
          Line::ShiftSubmissions::RegistShiftSubmissionService.new(
            reply_token: event['replyToken'],
            line_user_id: event['source']['userId']
          ).regist
        when 'shift_submission[cancel]'
          Line::ShiftSubmissions::CancelShiftSubmissionService.new(
            reply_token: event['replyToken'],
            line_user_id: event['source']['userId']
          ).cancel
        end
      when 'accountLink'
        case event['link']['result']
        when 'ok'
          Line::Accounts::CreateConnectionService.new(
            line_user_id: event['source']['userId'],
            nonce: event['link']['nonce']
          ).create
          Line::Richmenus::LinkConnectedRichmenuService.new(
            reply_token: event['replyToken'],
            line_user_id: event['source']['userId']
          ).link
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
