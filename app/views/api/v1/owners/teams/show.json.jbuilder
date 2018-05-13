json.array! @shift_submissions do |shift_submission|
  member = ember = shift_submission.member
  json.title "#{shift_submission.start_time}~#{shift_submission.end_time} #{member.user.last_name}#{member.user.first_name}"
  json.start Chronic.parse("#{shift_submission.submitted_date} #{shift_submission.start_time}")
  json.end Chronic.parse("#{shift_submission.submitted_date} #{shift_submission.end_time}")
  json.className 'shift-submission-source'
  json.textColor '#444'
  json.backgroundColor shift_submission.member.calendar_color
  json.borderColor shift_submission.member.calendar_color
  json.editable false
end

json.array! @shift_adjustments do |shift_adjustment|
  member = shift_adjustment.member
  json.title "#{shift_adjustment.start_time}~#{shift_adjustment.end_time} #{member.user.last_name}#{member.user.first_name}"
  json.start Chronic.parse("#{shift_adjustment.shift_submission.submitted_date} #{shift_adjustment.start_time}")
  json.end Chronic.parse("#{shift_adjustment.shift_submission.submitted_date} #{shift_adjustment.end_time}")
  json.textColor '#444'
  json.backgroundColor shift_adjustment.member.calendar_color
  json.borderColor shift_adjustment.member.calendar_color
  json.editable false
end
