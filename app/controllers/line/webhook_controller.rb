class Line::WebhookController < ApplicationController
  protect_from_forgery except: [:callback]

  def callback
    body = request.body.read
    events = client.parse_events_from(body)

    events.each do |event|
      case event['type']
      when 'follow'
        Line::LinkUnconnectedRichmenuService.new(event['source']['userId']).link
      when 'postback'
        case event['postback']['data']
        when 'connected'
          Line::CreateLinkTokenService.new(event['replyToken'], event['source']['userId']).create
        end
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
        # when 'connected'
        #   link_token = Line::CreateLinkTokenService.new(event['source']['userId']).create
        #   message = {
        #     type: 'text',
        #     text: "#{ENV['NGROK_URL']}/admins/line_connections/new?linkToken=#{link_token}"
        #   }
        #   client.reply_message(event['replyToken'], message)
        when 'shift_submission'
          Line::ReplyStartTimeSelectService.new(event['replyToken']).reply
        when 'shift_submission[start_time]'
          line_user_id = event['source']['userId']
          start_time = event['postback']['params']['datetime']
          Redis.current.hset(line_user_id, 'start_time', start_time)
          Line::ReplyEndTimeSelectService.new(event['replyToken'], start_time).reply
        when 'shift_submission[end_time]'
          line_user_id = event['source']['userId']
          start_time = Redis.current.hget(line_user_id, 'start_time')
          end_time = event['postback']['params']['datetime']
          Redis.current.hset(line_user_id, 'end_time', end_time)
          # if start_time = Redis.current.hget(line_user_id, 'start_time')
          #   submitted_date = start_time.to_date
          #   User.first.members.first.shift_submissions.create(submitted_date: submitted_date, start_time: start_time.to_time.strftime('%H:%M'), end_time: event['postback']['params']['datetime'].to_time.strftime('%H:%M'))
          # end
          Line::ConfirmShiftSubmissionService.new(event['replyToken'], start_time, end_time).confirm
        when 'shift_submission[regist]'
          line_user_id = event['source']['userId']
          start_time = Redis.current.hget(line_user_id, 'start_time')
          end_time = Redis.current.hget(line_user_id, 'end_time')
          Line::RegistShiftSubmissionService.new(event['replyToken'], start_time, end_time).regist
        when 'shift_submission[cancel]'
          line_user_id = event['source']['userId']
          start_time = Redis.current.hget(line_user_id, 'start_time')
          end_time = Redis.current.hget(line_user_id, 'end_time')
          Line::CancelShiftSubmissionService.new(event['replyToken'], start_time, end_time).cancel
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
