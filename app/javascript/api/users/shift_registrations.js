import apiClient from 'helpers/users/api_client'

export function getShiftRegistration (shiftRegistrationId) {
  return apiClient({
    url: 'shift_registrations/' + shiftRegistrationId
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

export function updateShiftRegistration (shiftRegistration) {
  return apiClient({
    method: 'patch',
    data: {
      shift_registration: {
        registered_date: shiftRegistration.registeredDate,
        start_time: shiftRegistration.startTime,
        end_time: shiftRegistration.endTime
      }
    },
    url: 'shift_registrations/' + shiftRegistration.id
  })
}
