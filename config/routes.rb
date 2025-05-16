Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  resources :credores, only: [ :show, :create ] do
    member do
      post "documentos", to: "documentos_pessoais#upload"
      post "certidoes", to: "certidoes#upload_manual"
      post "buscar-certidoes", to: "certidoes#buscar_api"
    end
  end

  namespace :api do
    get "certidoes", to: "certidoes#consultar"
  end
end
