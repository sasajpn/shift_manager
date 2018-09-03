import apiClient from 'helpers/admins/api_client'

export function getTeam (team_id) {
  return apiClient({
    url: '/teams/' + team_id
  })
}

export function createTeam (ownerId, team) {
  return apiClient({
    method: 'post',
    data: {
      team: {
        name: team.name,
        open_time: team.openTime,
        close_time: team.closeTime,
        max_member_count: team.maxMemberCount
      }
    },
    url: 'owners/' + ownerId + '/teams'
  })
}

export function updateTeam (team) {
  return apiClient({
    method: 'patch',
    data: {
      team: {
        name: team.name,
        open_time: team.openTime,
        close_time: team.closeTime,
        max_member_count: team.maxMemberCount
      }
    },
    url: 'teams/' + team.id
  })
}
