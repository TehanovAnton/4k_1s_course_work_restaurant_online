class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation, only: %i[update destroy show]

  def show    
    return render json: @reservation

    render json: { error: 'wrong reservation params' }
  end

  def create
    return render json: Reservation.create(reservation_params)

    render json: { error: 'wrong reservation params' }
  end

  def update
    authorize @reservation
    response = { error: 'wrong reservation params' }

    response = @reservation if @reservation.update(reservation_params)

    render json: response
  end

  def destroy
    authorize @reservation
    response = @reservation

    response = { error: 'wrong reservation params' } unless @reservation.destroy

    render json: response
  end

  private

  def set_reservation
    @reservation = Reservation.find_by(id: params[:id])

    update_auth_header
    render json: { error: 'wrong reservation params' } unless @reservation
  end

  def reservation_params
    reservation_params = [ 
      :table_id, 
      order_attributes: [
        :restaurant_id,
        :user_id,
        orders_dishes_attributes: [
          :dish_id
        ]
      ]
    ]

    params.require(:reservation).permit(reservation_params)
  end
end
