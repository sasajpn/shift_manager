import apiClient from 'helpers/api_client'

export function editShiftSubmission (shift_submission_id) {
  return apiClient({
    url: 'shift_submissions/' + shift_submission_id + '/edit'
  })
}
