class CredoresController < ApplicationController
  def create
    Credor.transaction do
      Rails.logger.info "==> Parâmetros recebidos: #{params.inspect}"
      credor = Credor.new(credor_params)

      if credor.save
        render json: credor, status: :created
      else
        render json: credor.errors.full_messages, status: :unprocessable_entity
      end
    end
  end

  def show
    credor = Credor.includes(:precatorios, :documentos_pessoais, :certidoes).find(params[:id])
    render json: credor
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Credor não encontrado" }, status: :not_found
  end

  private

  def credor_params
    params.permit(
      :nome,
      :cpf_cnpj,
      :email,
      :telefone,
      precatorio: [
        :numero_precatorio,
        :valor_nominal,
        :foro,
        :data_publicacao
      ]
    ).tap do |whitelisted|
      if params[:precatorio].present?
        whitelisted[:precatorios_attributes] = [ whitelisted.delete(:precatorio) ]
      end
    end
  end
end
