json.shift_submission do
  json.submitted_date @shift_submission.submitted_date
  json.start_time @shift_submission.start_time
  json.end_time @shift_submission.end_time
end
