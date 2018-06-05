json.array! @shift_adjustments do |shift_adjustment|
  json.id shift_adjustment.shift_submission.id
  json.title "#{shift_adjustment.start_time}~#{shift_adjustment.end_time}　#{shift_adjustment.member.user.name}"
  json.start Chronic.parse("#{shift_adjustment.shift_submission.submitted_date} #{shift_adjustment.start_time}")
  json.end Chronic.parse("#{shift_adjustment.shift_submission.submitted_date} #{shift_adjustment.end_time}")
  json.editable false
end
