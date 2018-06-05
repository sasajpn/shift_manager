//= require AdminLTE/moment.min
//= require AdminLTE/fullcalendar.min
//= require AdminLTE/fullcalendar/ja

function ShiftSubmissionsCalendar() {
  return $('#shift_submissions_calendar').fullCalendar({
    header: {
      center: '',
      right:  'month today prev,next'
    },
    noEventsMessage: 'シフト希望の提出がありません',
    timezone: 'Asia/Tokyo',
    selectable: true,
    displayEventTime: false,
    select: function(start, end, jsEvent, view) {
      $('#shift_submissions_calendar').fullCalendar('changeView', 'listDay', start);
    }
  })
}
