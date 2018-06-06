//= require AdminLTE/moment.min
//= require AdminLTE/fullcalendar.min
//= require AdminLTE/fullcalendar/ja

$(function() {
  var member_id = document.getElementById('users_shift_coordinators_shift_calendar').dataset.member_id

  $('#users_shift_coordinators_shift_calendar').fullCalendar({
    timezone: 'Asia/Tokyo',
    displayEventTime: false,
    eventSources: [
      {
        url: '/api/v1/users/shift_coordinators/members/' + member_id
      }
    ]
  })
})
