import apiClient from 'helpers/users/api_client'

export function getMember (memberId) {
  return apiClient({
    url: '/members/' + memberId
  })
}

export function updateMember (member) {
  return apiClient({
    method: 'patch',
    data: {
      member: {
        calendar_color: member.calendarColor,
      }
    },
    url: '/members/' + member.id
  })
}
