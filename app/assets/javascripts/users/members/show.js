//= require AdminLTE/moment.min
//= require AdminLTE/fullcalendar.min
//= require AdminLTE/fullcalendar/ja

$(function() {
  var member_id = document.getElementById('members_shift_calendar').dataset.member_id

  $('#members_shift_calendar').fullCalendar({
    header: {
      center: '',
      right:  'month today prev,next'
    },
    timezone: 'Asia/Tokyo',
    displayEventTime: false,
    noEventsMessage: 'シフトの希望、または調整されたシフトがありません',
    selectable: true,
    eventSources: [
      {
        url: '/api/v1/users/members/' + member_id + '/calendars'
      }
    ],
    select: function(start, end, jsEvent, view) {
      $('#members_shift_calendar').fullCalendar('changeView', 'listDay', start);
    },
    eventClick: function(event, jsEvent, view) {
      if (view.type === 'listDay') {
        if (event.shift_submission_id) {
          window.location.href = '/users/shift_submissions/' + event.shift_submission_id + '?referrer=members_shift_calendar'
        } else if (event.shift_registration_id) {
          window.location.href = '/users/shift_registrations/' + event.shift_registration_id
        }
      }
    }
  })
})
