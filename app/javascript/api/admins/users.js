import apiClient from 'helpers/admins/api_client'

export function getUsers () {
  return apiClient({
    url: 'users'
  })
}
