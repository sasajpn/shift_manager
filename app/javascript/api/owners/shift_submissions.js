import apiClient from 'helpers/owners/api_client'

export function getShiftSubmission (shiftSubmissionId) {
  return apiClient({
    url: 'shift_submissions/' + shiftSubmissionId
  })
}
