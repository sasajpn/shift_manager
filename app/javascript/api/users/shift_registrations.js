import apiClient from 'helpers/users/api_client'

export function newShiftRegistration (memberId) {
  return apiClient({
    url: 'members/' + memberId + '/shift_registrations/new'
  })
}

export function createShiftRegistration (memberId, shiftRegistration) {
  return apiClient({
    method: 'post',
    data: {
      shift_registration: {
        registered_date: shiftRegistration.registeredDate,
        start_time: shiftRegistration.startTime,
        end_time: shiftRegistration.endTime
      }
    },
    url: 'members/' + memberId + '/shift_registrations'
  })
}
