class Certidao < ApplicationRecord
  self.table_name = "certidoes"

  belongs_to :credor, foreign_key: "credor_id"

  TIPO_CERTIDAOS = %w[federal estadual municipal trabalhista]
  ORIGENS = %w[manual api]
  STATUSES = %w[negativa positiva invalida pendente]
end
