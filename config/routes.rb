Rails.application.routes.draw do
  root 'exchanges#index'
  get 'convert', to: 'exchanges#convert'
  get 'convert_bitcoin', to: 'exchanges#convert_bitcoin'
end