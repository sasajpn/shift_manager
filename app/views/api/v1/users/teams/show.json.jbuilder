json.array! @shift_submissions do |shift_submission|
  json.title "#{shift_submission.start_time}~#{shift_submission.end_time}"
  json.start Chronic.parse("#{shift_submission.submitted_date} #{shift_submission.start_time}")
  json.end Chronic.parse("#{shift_submission.submitted_date} #{shift_submission.end_time}")
  json.textColor '#444'
  json.backgroundColor '#f4f4f4'
  json.borderColor '#ddd'
  json.editable false
end

json.array! @shift_adjustments do |shift_adjustment|
  json.title "#{shift_adjustment.start_time}~#{shift_adjustment.end_time}"
  json.start Chronic.parse("#{shift_adjustment.shift_submission.submitted_date} #{shift_adjustment.start_time}")
  json.end Chronic.parse("#{shift_adjustment.shift_submission.submitted_date} #{shift_adjustment.end_time}")
  json.backgroundColor '#dd4b39'
  json.borderColor '#d73925'
  json.editable false
end
