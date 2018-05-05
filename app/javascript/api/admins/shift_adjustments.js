import apiClient from 'helpers/api_client'

export function newShiftAdjustment (shift_submission_id) {
  return apiClient({
    url: '/shift_submissions/' + shift_submission_id + '/shift_adjustments/new'
  })
}

export function editShiftAdjustment (shift_adjustment_id) {
  return apiClient({
    url: '/shift_adjustments/' + shift_adjustment_id + '/edit'
  })
}
