import apiClient from 'helpers/owners/api_client'

export function newShiftSubmission (memberId) {
  return apiClient({
    url: 'members/' + memberId + '/shift_submissions/new'
  })
}

export function createShiftSubmission (memberId, shiftSubmission) {
  return apiClient({
    method: 'post',
    data: {
      shift_submission: {
        submitted_date: shiftSubmission.submittedDate,
        start_time: shiftSubmission.startTime,
        end_time: shiftSubmission.endTime
      }
    },
    url: 'members/' + memberId + '/shift_submissions'
  })
}
