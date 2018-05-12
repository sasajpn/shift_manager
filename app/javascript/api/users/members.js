import apiClient from 'helpers/users/api_client'

export function editMember (memberId) {
  return apiClient({
    url: '/members/' + memberId + '/edit'
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
