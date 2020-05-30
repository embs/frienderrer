class CreditsService
  def initialize(user:, referral: nil)
    @user = user
    @referral = referral
  end

  def apply!
    return unless referral

    grant_new_user_credits
    grant_referral_user_credits
    referral.increment!(:referred_times)

    true
  end

  private

  attr_reader :user, :referral

  def grant_new_user_credits
    user.update(credits: user.credits + 10)
  end

  def grant_referral_user_credits
    return unless referral.referred_times == 4

    referral_user = referral.user

    referral_user.update(credits: referral_user.credits + 10)
  end
end
