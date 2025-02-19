class CheckoutController < ApplicationController
  def create
    @total = params[:total].to_d
    @event = Event.find(params[:event_id])

    @session = Stripe::Checkout::Session.create(
      payment_method_types: [ "card" ],
      line_items: [
        {
          price_data: {
            currency: "eur",
            unit_amount: (@total * 100).to_i,
            product_data: { name: @event.title }
          },
          quantity: 1
        }
      ],
      mode: "payment",
      success_url: checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: checkout_cancel_url,
      metadata: {
        event_id: @event.id,
        user_id: current_user.id
      }
    )

    redirect_to @session.url, allow_other_host: true
  end


  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)

    event_id = @session.metadata.event_id
    user_id = @session.metadata.user_id

    event = Event.find(event_id)
    user = User.find(user_id)

    unless Attendance.exists?(user: user, event: event)
      Attendance.create(user: user, event: event, stripe_customer_id: @session.id)
    end

    redirect_to event_path(event), notice: "Paiement réussi ! Tu es inscrit à l'événement."
  end


  def cancel
  end
end
