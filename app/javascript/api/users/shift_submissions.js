import apiClient from 'helpers/users/api_client'

export function newShiftSubmission (teamId) {
  return apiClient({
    url: '/teams/' + teamId + '/shift_submissions/new'
  })
}

export function editShiftSubmission (shiftSubmissionId) {
  return apiClient({
    url: 'shift_submissions/' + shiftSubmissionId + '/edit'
  })
}
