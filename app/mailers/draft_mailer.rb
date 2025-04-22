class DraftMailer < ApplicationMailer
  def invite_email(draft, email)
    @draft = draft
    @invite_url = draft_url(draft)
    mail(to: email, subject: "You've been invited to join Survivor Draft Season #{draft.season_number}")
  end
end
