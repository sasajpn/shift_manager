import apiClient from 'helpers/owners/api_client'

export function updateUnapproveMember (member) {
  return apiClient({
    method: 'patch',
    data: {
      member: {
        approve: true,
        role: member.role,
        shift_coordinator: member.shift_coordinator
      }
    },
    url: 'members/unapprovals/' + member.id
  })
}