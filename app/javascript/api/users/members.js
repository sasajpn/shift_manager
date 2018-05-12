import apiClient from 'helpers/users/api_client'

export function editMember (memberId) {
  return apiClient({
    url: '/members/' + memberId + '/edit'
  })
}
