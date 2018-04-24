import apiClient from 'helpers/api_client'

export function edit (id) {
  return apiClient({
    url: 'shift_submissions/' + id + '/edit'
  })
}

export function update (id, shiftSubmission, csrf) {
  return apiClient({
    url: 'shift_submissions/' + id,
    headers: {
      'X-CSRF-Token': csrf
    },
    method: 'PATCH',
    data: { shift_submission: shiftSubmission }
  })
}
