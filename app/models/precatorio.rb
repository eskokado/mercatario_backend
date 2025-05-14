class Precatorio < ApplicationRecord
  self.table_name = "precatorios"

  belongs_to :credor, foreign_key: "credor_id"
end
