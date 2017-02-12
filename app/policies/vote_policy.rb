class VotePolicy
  attr_reader :user, :vote

  def initialize(user, vote)
    @user = user
    @vote = vote
  end

  def create?
    user.id == vote.user_id
  end

end
