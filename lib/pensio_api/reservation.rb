module PensioAPI
  class Reservation
    def self.of_fixed_amount(options={})
      request = Request.new('/merchant/API/reservationOfFixedAmount', options)
      Responses::Reservation.new(request)
    end

    def initialize(transaction)
      @transaction = transaction
    end

    def capture(options={})
      request = Request.new('/merchant/API/captureReservation', options.merge(reservation_options))
      Responses::ReservationCapture.new(request)
    end

    def release(options={})
      request = Request.new('/merchant/API/releaseReservation', options.merge(reservation_options))
      Responses::ReservationRelease.new(request)
    end

    def refund(options={})
      request = Request.new('/merchant/API/refundCapturedReservation', options.merge(reservation_options))
      Responses::Refund.new(request)
    end

    private

    def reservation_options
      { transaction_id: @transaction.transaction_id }
    end
  end
end
