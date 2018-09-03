import apiClient from 'helpers/admins/api_client'

export function getMember (memberId) {
  return apiClient({
    url: 'members/' + memberId
  })
}

export function createMember (teamId, member) {
  return apiClient({
    method: 'post',
    data: {
      member: {
        user_id: member.userId,
        role: member.role,
        shift_coordinator: member.shiftCoordinator,
        calendar_color: member.calendarColor
      }
    },
    url: 'teams/' + teamId + '/members'
  })
}

export function updateMember (member) {
  return apiClient({
    method: 'patch',
    data: {
      team: {
        role: member.role,
        shift_coordinator: member.shiftCoordinator,
        calendar_color: member.calendarColor
      }
    },
    url: 'members/' + member.id
  })
}
