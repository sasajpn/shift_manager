json.team do
  business_hours_group_by_hour = @team.business_hours_group_by_hour
  json.business_hours business_hours_group_by_hour
  json.shift_in_counts Array.new(business_hours_group_by_hour.values.flatten.count, 0)
end
json.members @members do |member|
  shift_submissions = member.shift_submissions.where(submitted_date: @date)
  shift_adjustments = member.shift_adjustments.adjusted_date(@date)
  if shift_submissions.any? || shift_adjustments.any?
    json.id member.id
    json.name member.user.last_name + member.user.first_name
    json.shift_submissions shift_submissions do |shift_submission|
      json.start_time shift_submission.start_min_of_day
      json.end_time shift_submission.end_min_of_day
    end
    json.shift_adjustments shift_adjustments do |shift_adjustment|
      json.start_time shift_adjustment.start_min_of_day
      json.end_time shift_adjustment.end_min_of_day
    end
  end
end
