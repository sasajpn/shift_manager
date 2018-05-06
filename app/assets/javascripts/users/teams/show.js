//= require AdminLTE/adminlte.min
//= require AdminLTE/moment.min
//= require AdminLTE/fullcalendar.min
//= require AdminLTE/fullcalendar/ja

$(function() {

  $('#shift_calendar').fullCalendar({
    timezone: 'Asia/Tokyo',
    displayEventTime: false,
    eventSources: [
      {
        url: "/api/v1/users/teams/" + team_id
      }
    ]
  })
})
