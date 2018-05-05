import apiClient from 'helpers/admins/api_client'

export function newShiftSubmission (memberId) {
  return apiClient({
    url: '/members/' + memberId + '/shift_submissions/new'
  })
}

export function editShiftSubmission (shift_submission_id) {
  return apiClient({
    url: 'shift_submissions/' + shift_submission_id + '/edit'
  })
}
