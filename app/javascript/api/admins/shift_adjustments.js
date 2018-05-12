import apiClient from 'helpers/admins/api_client'

export function newShiftAdjustment (shiftSubmissionId) {
  return apiClient({
    url: '/shift_submissions/' + shiftSubmissionId + '/shift_adjustments/new'
  })
}

export function editShiftAdjustment (shift_adjustment_id) {
  return apiClient({
    url: '/shift_adjustments/' + shift_adjustment_id + '/edit'
  })
}
