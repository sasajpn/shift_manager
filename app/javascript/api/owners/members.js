import apiClient from 'helpers/owners/api_client'

export function editMember (memberId) {
  return apiClient({
    url: '/members/' + memberId + '/edit'
  })
}

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
        role: member.role,
        shift_coordinator: member.shift_coordinator
      }
    },
    url: '/members/' + member.id
  })
}
