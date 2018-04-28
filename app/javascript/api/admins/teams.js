import apiClient from 'helpers/api_client'

export function editTeam (team_id) {
  return apiClient({
    url: '/teams/' + team_id + '/edit'
  })
}
