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
        url: '/api/v1/users/part_timers/members/' + member_id
      }
    ],
    select: function(start, end, jsEvent, view) {
      $('#members_shift_calendar').fullCalendar('changeView', 'listDay', start);
    },
    eventClick: function(event, jsEvent, view) {
      if (view.type === 'listDay') {
        if (event.shift_submission_id) {
          window.location.href = '/users/part_timers/shift_submissions/' + event.shift_submission_id
        } else if (event.shift_registration_id) {
          window.location.href = '/users/part_timers/shift_registrations/' + event.shift_registration_id + '/edit'
        }
      }
    }
  })
})
