json.array! @member.shift_submissions do |shift_submission|
  json.start shift_submission.start_time
  json.end shift_submission.end_time
  json.editable false
end
