class ContactMailer < ApplicationMailer
  def contact_mail(contact)
    @contact = contact
    mail to: "ooreicookoo@gmail.com", subject: "instagramen投稿確認メール"
  end
end
