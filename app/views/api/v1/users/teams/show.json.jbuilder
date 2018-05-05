json.array! @shift_submissions do |shift_submission|
  json.title "#{shift_submission.start_time}~#{shift_submission.end_time}"
  json.start Chronic.parse("#{shift_submission.submitted_date} #{shift_submission.start_time}")
  json.end Chronic.parse("#{shift_submission.submitted_date} #{shift_submission.end_time}")
  json.textColor '#444'
  json.backgroundColor '#f4f4f4'
  json.borderColor '#ddd'
  json.editable false
end
