json.array! @shift_submissions do |shift_submission|
  json.shift_submission_id shift_submission.id
  json.title "#{shift_submission.start_time}~#{shift_submission.end_time}"
  json.start Chronic.parse("#{shift_submission.submitted_date} #{shift_submission.start_time}")
  json.end Chronic.parse("#{shift_submission.submitted_date} #{shift_submission.end_time}")
  json.className 'shift-submission-source'
  json.editable false
end

json.array! @shift_adjustments do |shift_adjustment|
  json.shift_submission_id shift_adjustment.shift_submission.id
  json.title "#{shift_adjustment.start_time}~#{shift_adjustment.end_time}"
  json.start Chronic.parse("#{shift_adjustment.shift_submission.submitted_date} #{shift_adjustment.start_time}")
  json.end Chronic.parse("#{shift_adjustment.shift_submission.submitted_date} #{shift_adjustment.end_time}")
  json.editable false
end

json.array! @shift_registrations do |shift_registration|
  json.shift_registration_id shift_registration.id
  json.title "#{shift_registration.start_time}~#{shift_registration.end_time}"
  json.start Chronic.parse("#{shift_registration.registered_date} #{shift_registration.start_time}")
  json.end Chronic.parse("#{shift_registration.registered_date} #{shift_registration.end_time}")
  json.backgroundColor '#FA3932'
  json.borderColor '#FA3932'
  json.editable false
end
