# == Schema Information
#
# Table name: precatorios
#
#  id                :integer          not null, primary key
#  credor_id         :integer
#  numero_precatorio :string
#  valor_nominal     :decimal(, )
#  foro              :string
#  data_publicacao   :date
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_precatorios_on_credor_id  (credor_id) UNIQUE
#

class Precatorio < ApplicationRecord
  self.table_name = "precatorios"

  belongs_to :credor, foreign_key: "credor_id", inverse_of: :precatorios

  before_validation :set_credor_id, if: -> { credor.present? }

  private

  def set_credor_id
    self.credor_id ||= credor.id
  end
end
