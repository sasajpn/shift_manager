import apiClient from 'helpers/owners/api_client'

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

export function editTeam (teamId) {
  return apiClient({
    url: 'teams/' + teamId + '/edit'
  })
}

export function updateTeam (team) {
  return apiClient({
    method: 'patch',
    data: {
      team: {
        name: team.name,
        open_time: team.openTime,
        close_time: team.closeTime
      }
    },
    url: 'teams/' + team.id
  })
}
