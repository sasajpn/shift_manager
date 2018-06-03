import apiClient from 'helpers/users/api_client'

export function createShiftAdjustment (shiftSubmissionId, shiftAdjustment) {
  return apiClient({
    method: 'post',
    data: {
      shift_adjustment: {
        start_time: shiftAdjustment.startTime,
        end_time: shiftAdjustment.endTime
      }
    },
    url: 'shift_submissions/' + shiftSubmissionId + '/shift_adjustments'
  })
}
