import apiClient from 'helpers/admins/api_client'

export function createTeam (team) {
  return apiClient({
    method: 'post',
    data: {
      team: {
        name: team.name,
        open_time: team.openTime,
        close_time: team.closeTime
      }
    },
    url: 'teams'
  })
}

export function editTeam (team_id) {
  return apiClient({
    url: '/teams/' + team_id + '/edit'
  })
}
