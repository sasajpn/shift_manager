import apiClient from 'helpers/api_client'

export function newShiftSubmission (memberId) {
  return apiClient({
    url: '/members/' + memberId + '/shift_submissions/new'
  })
}
