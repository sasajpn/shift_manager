//= require AdminLTE/moment.min
//= require AdminLTE/fullcalendar.min
//= require AdminLTE/fullcalendar/ja

$(function() {
  var team_id = document.getElementById('shift_submissions_calendar').dataset.team_id

  $('#shift_submissions_calendar').fullCalendar({
    header: {
      center: '',
      right:  'month today prev,next'
    },
    noEventsMessage: 'シフト希望の提出がありません',
    timezone: 'Asia/Tokyo',
    selectable: true,
    displayEventTime: false,
    eventSources: [
      {
        url: '/api/v1/users/part_timers/teams/' + team_id + '/shift_submissions'
      }
    ],
    select: function(start, end, jsEvent, view) {
      $('#shift_submissions_calendar').fullCalendar('changeView', 'listDay', start);
    },
    eventClick: function(event, jsEvent, view) {
      window.location.href = '/users/part_timers/shift_submissions/' + event.id
    }
  })
})
