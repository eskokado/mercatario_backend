class Precatorio < ApplicationRecord
  self.table_name = "precatorios"

  belongs_to :credor, foreign_key: "credor_id", inverse_of: :precatorios

  before_validation :set_credor_id, if: -> { credor.present? }

  private

  def set_credor_id
    self.credor_id ||= credor.id
  end
end
