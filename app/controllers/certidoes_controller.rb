class CertidoesController < ApplicationController
  before_action :set_credor

  def upload_manual
    certidao = @credor.certidoes.new(tipo: params[:tipo], origem: params[:origem], status: params[:status])

    if params[:arquivo].present?
      certidao.arquivo.attach(params[:arquivo])

      if certidao.save
        arquivo_url = rails_blob_url(certidao.arquivo, host: request.base_url)
        certidao.update_columns(arquivo_url: arquivo_url, recebida_em: Time.current)

        render json: { success: true, message: "Certidão salvo com sucesso" }, status: :ok
      else
        render json: { errors: certidao.errors }, status: :unprocessable_entity
      end
    else
      render json: { errors: { arquivo: [ "não pode ficar em branco" ] } }, status: :unprocessable_entity
    end
  end

  def buscar_api
    certidoes = @credor.certidoes.order(recebida_em: :desc)
    render json: certidoes
  end

  private

  def set_credor
    @credor = Credor.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Credor não encontrado" }, status: :not_found
  end
end
