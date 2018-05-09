module Line
  module ShiftSubmissions
    class ReplyTeamSelectService < Line::ShiftSubmissions::BaseService

      def reply
        delete_team_id
        delete_start_time
        delete_end_time
        set_before_action('shift_submission')
        request_team_select
      end

      private

      def all_teams
        account = get_line_connection&.account
        account.teams
      end

      def set_actions(teams)
        actions = []
        teams.each do |team|
          action = {
            type: 'postback',
            label: "#{team.name}",
            data: "shift_submission[team]=#{team.id}"
          }
          actions << action
        end
        actions
      end

      def request_team_select
        body = [
          {
            type: 'template',
            altText: 'This is a buttons template',
            template: {
              type: 'buttons',
              title: 'シフト希望提出先のチーム',
              text: 'どちらのチームにシフト希望を提出しますか？',
              actions: set_actions(all_teams)
            }
          }
        ]
        reply_message(body)
      end

    end
  end
end
