class FeedMailer < ApplicationMailer
  def feed_mail(feed)
      @feed = feed
      mail to: "#{@feed.user.email}", subject: "feed投稿時の確認メール"
  end
end
