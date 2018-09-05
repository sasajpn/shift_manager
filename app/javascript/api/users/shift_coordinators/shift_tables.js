import apiClient from 'helpers/users/api_client'

export function getShiftTable (teamId, date) {
  return apiClient({
    url: 'shift_coordinators/teams/' + teamId + '/shift_tables?date=' + date
  })
}
