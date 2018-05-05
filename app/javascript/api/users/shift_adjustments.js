import apiClient from 'helpers/users/api_client'

export function newShiftAdjustment (shiftSubmissionId) {
  return apiClient({
    url: '/shift_submissions/' + shiftSubmissionId + '/shift_adjustments/new'
  })
}
