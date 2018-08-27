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
    noEventsMessage: 'シフトの希望、または調整されたシフトがありません',
    timezone: 'Asia/Tokyo',
    selectable: true,
    displayEventTime: false,
    eventSources: [
      {
        url: '/api/v1/users/shift_coordinators/members/' + member_id + '/calendars'
      }
    ],
    select: function(start, end, jsEvent, view) {
      $('#members_shift_calendar').fullCalendar('changeView', 'listDay', start);
    },
    eventClick: function(event, jsEvent, view) {
      if (view.type === 'listDay') {
        if (event.shift_submission_id) {
          window.location.href = '/users/shift_coordinators/shift_submissions/' + event.shift_submission_id + '?referrer=members_shift_calendar'
        } else if (event.shift_registration_id) {
          window.location.href = '/users/shift_coordinators/shift_registrations/' + event.shift_registration_id + '/edit?referrer=members_shift_calendar'
        }
      }
    }
  })
})
