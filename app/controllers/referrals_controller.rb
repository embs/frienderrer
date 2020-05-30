class ReferralsController < ApplicationController
  def create
    user = User.find(user_id)
    referral = Referral.create!(user_id: user_id)

    render json: { referral: { id: referral.id } }, status: :created
  rescue ActionController::ParameterMissing
    render json: { error: I18n.t('.referrals.create.parameter_missing') },
           status: :unprocessable_entity
  rescue ActiveRecord::RecordNotFound
    render json: { error: I18n.t('.referrals.create.user_not_found') },
           status: :not_found
  end

  private

  def user_id
    params.require(:referral).require(:user_id)
  end
end
