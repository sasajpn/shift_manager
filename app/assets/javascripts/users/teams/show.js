//= require AdminLTE/moment.min
//= require AdminLTE/fullcalendar.min
//= require AdminLTE/fullcalendar/ja

$(function() {
  var team_id = document.getElementById('users_shift_calendar').dataset.team_id

  $('#users_shift_calendar').fullCalendar({
    timezone: 'Asia/Tokyo',
    displayEventTime: false,
    eventSources: [
      {
        url: '/api/v1/users/teams/' + team_id + '/calendars'
      }
    ]
  })
})
