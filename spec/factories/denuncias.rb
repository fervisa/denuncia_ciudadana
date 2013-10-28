# encoding: UTF-8
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :denuncia do
    funcionario "Juan Pérez"
    queja "Muy prepotente en su trato"
    email "denunciante@mail.com"
    association :dependencia, factory: :dependencia
    finalizada true
  end
end
