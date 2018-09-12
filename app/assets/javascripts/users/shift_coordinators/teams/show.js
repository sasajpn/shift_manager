//= require AdminLTE/moment.min
//= require AdminLTE/fullcalendar.min
//= require AdminLTE/fullcalendar/ja

$(function() {
  var team_id = document.getElementById('teams_shift_calendar').dataset.team_id

  $('#teams_shift_calendar').fullCalendar({
    header: {
      center: '',
      right:  'month today prev,next'
    },
    noEventsMessage: 'シフト希望の提出がありません',
    timezone: 'Asia/Tokyo',
    selectable: true,
    eventLimit: true,
    displayEventTime: false,
    eventSources: [
      {
        url: '/api/v1/users/shift_coordinators/teams/' + team_id + '/calendars'
      }
    ],
    select: function(start, end, jsEvent, view) {
      $('#teams_shift_calendar').fullCalendar('changeView', 'listDay', start);
    },
    eventClick: function(event, jsEvent, view) {
      if (view.type === 'listDay') {
        if (event.shift_submission_id) {
          window.location.href = '/users/shift_coordinators/shift_submissions/' + event.shift_submission_id
        } else if (event.shift_registration_id) {
          window.location.href = '/users/shift_coordinators/shift_registrations/' + event.shift_registration_id + '/edit'
        }
      }
    }
  })
})
