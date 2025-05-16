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

FactoryBot.define do
  factory :precatorio do
    sequence(:numero_precatorio, 1000) { |n| "PREC-#{n}" }
    valor_nominal { 1000.50 }
    foro { "Foro Central" }
    data_publicacao { Date.today }
    credor
  end
end
