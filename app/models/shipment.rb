class Shipment
  attr_reader :errors, :yaourts, :cheeses

  def initialize(hash)
    @cheeses = hash["cheeses"] || {}
    @yaourts = hash["yaourts"] || {}
    @errors  = []
  end

  def valid_for?(user)
    valid      = true
    nb_yaourts = @yaourts.values.map(&:to_i).sum
    nb_cheeses = @cheeses.values.map(&:to_i).sum

    if nb_yaourts > user.nb_yaourts
      valid = false

      @errors << I18n.t('shipment.errors.too_many_yaourts', {
        nb_yaourts: nb_yaourts,
        max_yaourts: user.nb_yaourts
      })
    end

    if nb_cheeses > user.cart.nb_cheeses
      valid = false

      @errors << I18n.t('shipment.errors.too_many_cheeses', {
        nb_cheeses: nb_cheeses,
        max_cheeses: user.cart.nb_cheeses
      })
    end

    valid
  end
end