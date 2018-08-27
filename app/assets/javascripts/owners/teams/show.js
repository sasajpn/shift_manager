//= require AdminLTE/moment.min
//= require AdminLTE/fullcalendar.min
//= require AdminLTE/fullcalendar/ja

$(function() {
  var team_id = document.getElementById('owners_shift_calendar').dataset.team_id

  $('#owners_shift_calendar').fullCalendar({
    header: {
      center: '',
      right:  'month today prev,next'
    },
    noEventsMessage: 'シフトの希望、または調整されたシフトがありません',
    timezone: 'Asia/Tokyo',
    displayEventTime: false,
    selectable: true,
    select: function(start, end, jsEvent, view) {
      $('#owners_shift_calendar').fullCalendar('changeView', 'listDay', start);
    },
    eventSources: [
      {
        url: '/api/v1/owners/teams/' + team_id + '/calendars'
      }
    ],
    eventClick: function(event, jsEvent, view) {
      if (view.type === 'listDay') {
        if (event.shift_submission_id) {
          window.location.href = '/owners/shift_submissions/' + event.shift_submission_id
        } else if (event.shift_registration_id) {
          window.location.href = '/owners/shift_registrations/' + event.shift_registration_id + '/edit'
        }
      }
    }
  })
})
