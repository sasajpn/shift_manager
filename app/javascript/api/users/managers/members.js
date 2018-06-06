import apiClient from 'helpers/users/api_client'

export function editMember (memberId) {
  return apiClient({
    url: 'managers/members/' + memberId + '/edit'
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
    url: 'managers/members/' + member.id
  })
}
