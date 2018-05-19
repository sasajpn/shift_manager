json.team do
  json.business_hours @team.business_hours_group_by_hour
end
json.members @members do |member|
  if member.shift_submissions.any?
    json.id member.id
    json.name member.user.last_name + member.user.first_name
    json.shift_submissions member.shift_submissions.unapprovals do |shift_submission|
      start_min_of_day = shift_submission.start_time.split(':').map(&:to_i)
      end_min_of_day = shift_submission.end_time.split(':').map(&:to_i)
      json.start_time start_min_of_day[0] * 60 + start_min_of_day[1]
      json.end_time end_min_of_day[0] * 60 + end_min_of_day[1]
    end
  end
end
