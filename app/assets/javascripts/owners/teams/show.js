//= require AdminLTE/moment.min
//= require AdminLTE/fullcalendar.min
//= require AdminLTE/fullcalendar/ja

$(function() {
  var team_id = document.getElementById('owners_shift_calendar').dataset.team_id

  $('#owners_shift_calendar').fullCalendar({
    timezone: 'Asia/Tokyo',
    displayEventTime: false,
    eventSources: [
      {
        url: '/api/v1/owners/teams/' + team_id + '/calendars'
      }
    ]
  })
})
