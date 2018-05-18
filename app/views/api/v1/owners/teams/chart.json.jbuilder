json.set! :hours, ['9', '10', '11', '12', '13', '14', '15', '16', '17', '18']
json.members @members do |member|
  json.id member.id
  json.name member.user.last_name + member.user.first_name
  json.shift_submissions member.shift_submissions.unapprovals do |shift_submission|
    json.start_time shift_submission.start_time
    json.colSpan shift_submission.colspan
  end
end
