import apiClient from 'helpers/users/api_client'

export function createUnapprovalMember (joinTeamForm) {
  return apiClient({
    method: 'post',
    data: {
      join_team_form: {
        identifier: joinTeamForm.identifier,
        calendar_color: joinTeamForm.calendarColor
      }
    },
    url: 'members/unapprovals'
  })
}
