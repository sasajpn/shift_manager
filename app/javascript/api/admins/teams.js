import apiClient from 'helpers/admins/api_client'

export function editTeam (team_id) {
  return apiClient({
    url: '/teams/' + team_id + '/edit'
  })
}
