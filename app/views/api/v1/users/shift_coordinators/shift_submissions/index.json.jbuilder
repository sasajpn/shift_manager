json.array! @shift_submissions do |shift_submission|
  json.id shift_submission.id
  json.title "#{shift_submission.start_time}~#{shift_submission.end_time}　#{shift_submission.member.user.name}"
  json.start Chronic.parse("#{shift_submission.submitted_date} #{shift_submission.start_time}")
  json.end Chronic.parse("#{shift_submission.submitted_date} #{shift_submission.end_time}")
  json.className 'shift-submission-unapprove' unless shift_submission.approve
  json.editable false
end
