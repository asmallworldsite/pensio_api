# frozen_string_literal: true

module PensioAPI
  class Reservation
    def self.of_fixed_amount(options = {})
      request = Request.new('/merchant/API/reservationOfFixedAmount', options)
      Responses::Reservation.new(request)
    end

    def initialize(transaction)
      @transaction = transaction
    end

    def capture(options = {})
      request = Request.new('/merchant/API/captureReservation', options.merge(reservation_options))
      Responses::ReservationCapture.new(request)
    end

    def release(options = {})
      request = Request.new('/merchant/API/releaseReservation', options.merge(reservation_options))
      Responses::ReservationRelease.new(request)
    end

    private

    def reservation_options
      { transaction_id: @transaction.id }
    end
  end
end
