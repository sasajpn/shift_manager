import apiClient from 'helpers/users/api_client'

export function getShiftAdjustment (shiftAdjustmentId) {
  return apiClient({
    url: 'shift_adjustments/' + shiftAdjustmentId
  })
}

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

export function updateShiftAdjustment (shiftAdjustment) {
  return apiClient({
    method: 'patch',
    data: {
      shift_adjustment: {
        start_time: shiftAdjustment.startTime,
        end_time: shiftAdjustment.endTime
      }
    },
    url: 'shift_adjustments/' + shiftAdjustment.id
  })
}
