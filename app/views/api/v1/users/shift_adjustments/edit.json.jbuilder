json.shift_adjustment do
  json.start_time @shift_adjustment.start_time
  json.end_time @shift_adjustment.end_time
end
json.shift_submission do
  json.id @shift_submission.id
  json.submitted_date @shift_submission.submitted_date
  json.start_time @shift_submission.start_time
  json.end_time @shift_submission.end_time
end
