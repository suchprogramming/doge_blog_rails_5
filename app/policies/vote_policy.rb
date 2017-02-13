class VotePolicy
  attr_reader :user, :vote

  def initialize(user, vote)
    @user = user
    @vote = vote
  end

  def create?
    user.active? && user.id == vote.user_id && %w(SuperAdmin Admin).exclude?(user.class.to_s)
  end

end
