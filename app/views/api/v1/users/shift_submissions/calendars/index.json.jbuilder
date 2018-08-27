json.array! @shift_submissions do |shift_submission|
  json.shift_submission_id shift_submission.id
  json.title "#{shift_submission.start_time}~#{shift_submission.end_time}"
  json.start Chronic.parse("#{shift_submission.submitted_date} #{shift_submission.start_time}")
  json.end Chronic.parse("#{shift_submission.submitted_date} #{shift_submission.end_time}")
  json.className 'shift-submission-unapprove' unless shift_submission.approve
  json.editable false
  json.textColor shift_submission.member.calendar_font_color
  json.backgroundColor shift_submission.member.calendar_color
  json.borderColor shift_submission.member.calendar_color
end

json.array! @shift_adjustments do |shift_adjustment|
  shift_submission = shift_adjustment.shift_submission
  json.shift_submission_id shift_submission.id
  json.title "#{shift_adjustment.start_time}~#{shift_adjustment.end_time} (#{shift_submission.start_time}~#{shift_submission.end_time})"
  json.start Chronic.parse("#{shift_adjustment.shift_submission.submitted_date} #{shift_adjustment.start_time}")
  json.end Chronic.parse("#{shift_adjustment.shift_submission.submitted_date} #{shift_adjustment.end_time}")
  json.editable false
  json.textColor shift_submission.member.calendar_font_color
  json.backgroundColor shift_submission.member.calendar_color
  json.borderColor shift_submission.member.calendar_color
end
