class UsersController < ApplicationController
  def create
    user = User.create(user_params)

    CreditsService.new(user: user, referral: referral).apply!
  rescue ActionController::ParameterMissing
    render json: { error: I18n.t('.users.create.parameter_missing') },
           status: :unprocessable_entity
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end

  def referral
    Referral.find_by(id: params[:referral_id])
  end
end
