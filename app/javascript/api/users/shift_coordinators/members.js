import apiClient from 'helpers/users/api_client'

export function getMember (memberId) {
  return apiClient({
    url: 'shift_coordinators/members/' + memberId
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
    url: 'shift_coordinators/members/' + member.id
  })
}
