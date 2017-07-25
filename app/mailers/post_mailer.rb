class PostMailer < ActionMailer::Base
  default from: "anat@konimbo.co.il"

  def new_comment(post)
    @post = post

    mail to: post.email, subject: "new comment"
  end
end
