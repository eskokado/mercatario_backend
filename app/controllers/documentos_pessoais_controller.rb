class DocumentosPessoaisController < ApplicationController
  before_action :set_credor

  def upload
    documento = @credor.documentos_pessoais.new(tipo: params[:tipo])

    if params[:arquivo].present?
      documento.arquivo.attach(params[:arquivo])

      if documento.save
        arquivo_url = rails_blob_url(documento.arquivo, host: request.base_url)
        documento.update_columns(arquivo_url: arquivo_url, enviado_em: Time.current)

        render json: { success: true, message: "Documento salvo com sucesso" }, status: :ok
      else
        render json: { errors: documento.errors }, status: :unprocessable_entity
      end
    else
      render json: { errors: { arquivo: [ "não pode ficar em branco" ] } }, status: :unprocessable_entity
    end
  end

  private

  def set_credor
    @credor = Credor.find(params[:credor_id] || params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Credor não encontrado" }, status: :not_found
  end
end
