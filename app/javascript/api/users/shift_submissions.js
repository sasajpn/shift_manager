import apiClient from 'helpers/users/api_client'

export function newShiftSubmission (teamId) {
  return apiClient({
    url: '/teams/' + teamId + '/shift_submissions/new'
  })
}
