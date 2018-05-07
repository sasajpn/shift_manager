import apiClient from 'helpers/users/api_client'

export function newShiftAdjustment (shiftSubmissionId) {
  return apiClient({
    url: '/shift_submissions/' + shiftSubmissionId + '/shift_adjustments/new'
  })
}

export function createShiftAdjustment (shiftSubmission, shiftAdjustment) {
  return apiClient({
    method: 'post',
    data: {
      shift_adjustment: {
        start_time: shiftAdjustment.startTime,
        end_time: shiftAdjustment.endTime
      }
    },
    url: 'shift_submissions/' + shiftSubmission.id + '/shift_adjustments'
  })
}
