class DeviseCustomMailer < Devise::Mailer
  helper :application
  include Devise::Controllers::UrlHelpers
  default template_path: 'devise/mailer'

  def confirmation_instructions(record, token, options={})
    if record.pending_reconfirmation?
      options[:template_name] = 'reconfirmation_instructions'
    else
      options[:template_name] = 'confirmation_instructions'
    end

    super
  end
end
