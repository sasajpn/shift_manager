//= require AdminLTE/moment.min
//= require AdminLTE/fullcalendar.min
//= require AdminLTE/fullcalendar/ja

$(function() {
  var team_id = document.getElementById('shift_adjustments_calendar').dataset.team_id

  $('#shift_adjustments_calendar').fullCalendar({
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
        url: '/api/v1/users/teams/' + team_id + '/shift_adjustments'
      }
    ],
    select: function(start, end, jsEvent, view) {
      $('#shift_adjustments_calendar').fullCalendar('changeView', 'listDay', start);
    },
    eventClick: function(event, jsEvent, view) {
      if (view.type === 'listDay') {
        window.location.href = '/users/managers/shift_submissions/' + event.id
      }
    }
  })
})
