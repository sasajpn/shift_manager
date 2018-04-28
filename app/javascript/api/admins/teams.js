import apiClient from 'helpers/api_client'

export function editTeam (team_id) {
  return apiClient({
    url: '/api/v1/admins/teams/' + team_id + '/edit'
  })
}
