class Ability
  include CanCan::Ability

  def initialize(user)
    if user.class == Merchant
      can :manage, Activity
    elsif user.class == User
      can :read, Activity
    end
  end
end
