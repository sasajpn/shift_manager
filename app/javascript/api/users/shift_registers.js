import apiClient from 'helpers/users/api_client'

export function newShiftRegister (memberId) {
  return apiClient({
    url: 'members/' + memberId + '/shift_registers/new'
  })
}

export function createShiftRegister (memberId, shiftSubmission, shiftAdjustment) {
  return apiClient({
    method: 'post',
    data: {
      shift_submission: {
        submitted_date: shiftSubmission.submittedDate,
        start_time: shiftSubmission.startTime,
        end_time: shiftSubmission.endTime,
        shift_adjustment_attributes: {
          start_time: shiftAdjustment.startTime,
          end_time: shiftAdjustment.endTime
        }
      }
    },
    url: 'members/' + memberId + '/shift_registers'
  })
}
