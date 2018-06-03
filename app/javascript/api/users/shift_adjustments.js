import apiClient from 'helpers/users/api_client'

export function createShiftAdjustment (shiftSubmissionId, shiftAdjustment) {
  return apiClient({
    method: 'post',
    data: {
      shift_adjustment: {
        start_time: shiftAdjustment.adjustmentStartTime,
        end_time: shiftAdjustment.adjustmentEndTime
      }
    },
    url: 'shift_submissions/' + shiftSubmissionId + '/shift_adjustments'
  })
}
