//= require AdminLTE/moment.min
//= require AdminLTE/fullcalendar.min
//= require AdminLTE/fullcalendar/ja

$(function() {
  var member_id = document.getElementById('shift_submissions_calendar').dataset.member_id

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
        url: '/api/v1/users/members/' + member_id + '/shift_submissions/calendars'
      }
    ],
    select: function(start, end, jsEvent, view) {
      $('#shift_submissions_calendar').fullCalendar('changeView', 'listDay', start);
    },
    eventClick: function(event, jsEvent, view) {
      if (view.type === 'listDay') {
        window.location.href = '/users/shift_submissions/' + event.id
      }
    }
  })
})
