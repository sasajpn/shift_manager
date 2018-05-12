//= require AdminLTE/moment.min
//= require AdminLTE/fullcalendar.min
//= require AdminLTE/fullcalendar/ja

$(function() {

  $('#shift_calendars').fullCalendar({
    timezone: 'Asia/Tokyo',
    displayEventTime: false,
    eventSources: [
      {
        url: '/api/v1/users/home'
      }
    ]
  })
})
