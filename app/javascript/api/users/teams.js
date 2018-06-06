import apiClient from 'helpers/users/api_client'

export function getTeam (teamId) {
  return apiClient({
    url: 'teams/' + teamId
  })
}
