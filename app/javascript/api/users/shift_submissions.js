import apiClient from 'helpers/users/api_client'

export function getShiftSubmission (shiftSubmissionId) {
  return apiClient({
    url: 'shift_submissions/' + shiftSubmissionId
  })
}

export function newShiftSubmission (teamId) {
  return apiClient({
    url: 'teams/' + teamId + '/shift_submissions/new'
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

export function editShiftSubmission (shiftSubmissionId) {
  return apiClient({
    url: 'shift_submissions/' + shiftSubmissionId + '/edit'
  })
}

export function updateShiftSubmission (shiftSubmission) {
  return apiClient({
    method: 'patch',
    data: {
      shift_submission: {
        submitted_date: shiftSubmission.submittedDate,
        start_time: shiftSubmission.startTime,
        end_time: shiftSubmission.endTime
      }
    },
    url: 'shift_submissions/' + shiftSubmission.id
  })
}
