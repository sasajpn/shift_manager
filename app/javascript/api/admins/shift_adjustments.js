import apiClient from 'helpers/api_client'

export function getShiftSubmission (shift_submission_id) {
  return apiClient({
    url: '/shift_submissions/' + shift_submission_id + '/shift_adjustments/new'
  })
}
