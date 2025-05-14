class Certidao < ApplicationRecord
  belongs_to :credor
  TIPO_CERTIDAOS = %w[federal estadual municipal trabalhista]
  ORIGENS = %w[manual api]
  STATUSES = %w[negativa positiva invalida pendente]
end
