json.array! @shift_submissions do |shift_submission|
  json.title "#{shift_submission.start_time}~#{shift_submission.end_time}"
  json.start Chronic.parse("#{shift_submission.submitted_date} #{shift_submission.start_time}")
  json.end Chronic.parse("#{shift_submission.submitted_date} #{shift_submission.end_time}")
  json.editable false
end
