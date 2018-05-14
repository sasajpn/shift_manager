import apiClient from 'helpers/users/api_client'

export function newShiftSubmission (memberId) {
  return apiClient({
    url: 'shift_coordinators/members/' + memberId + '/shift_submissions/new'
  })
}

export function createShiftSubmission (memberId, shiftSubmission, shiftAdjustment) {
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
    url: 'shift_coordinators/members/' + memberId + '/shift_submissions'
  })
}
