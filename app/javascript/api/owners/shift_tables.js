import apiClient from 'helpers/owners/api_client'

export function indexShiftTable (teamId, date) {
  return apiClient({
    url: 'teams/' + teamId + '/shift_tables?date=' + date
  })
}
