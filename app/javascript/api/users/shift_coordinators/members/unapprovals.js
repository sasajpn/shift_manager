import apiClient from 'helpers/users/api_client'

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
    url: 'shift_coordinators/unapprovals/' + member.id
  })
}
