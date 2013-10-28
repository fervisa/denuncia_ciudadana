# encoding: UTF-8

Dado(/^que cuento con un catálogo de dependencias$/) do
  FactoryGirl.create :dependencia
  FactoryGirl.create :dependencia, nombre: 'Fondo PyME'
end

Dado(/^que visito la página de inicio$/) do
  visit root_path
end

Dado(/^que visito la página de crear denuncia$/) do
  visit new_denuncia_path
end

Cuando(/^capturo la información de la denuncia$/) do
  rellenar_denuncia
  click_button 'Crear denuncia'
end

Cuando(/^capturo la información de la denuncia y adjunto imágenes$/) do
  rellenar_denuncia
  attach_file 'archivos', 'spec/fixtures/files/image-1.png'
  click_button 'Crear denuncia'
end

Cuando(/^capturo la información de la denuncia y adjunto archivos$/) do
  rellenar_denuncia
  attach_file 'archivos', 'spec/fixtures/files/file'
  click_button 'Crear denuncia'
end

Cuando(/^capturo la información de la denuncia y elijo la opción 'Limpiar'$/) do
  rellenar_denuncia
  within 'div[data-role="navbar"]' do
    click_link 'Limpiar'
  end
  within '#confirm-clean' do
    click_link 'Limpiar'
  end
end

Cuando(/^doy click en el enlace "(.*?)"$/) do |msg|
  page.click_link(msg)
end

Entonces(/^debo visualizar el formulario de denuncia$/) do
  page.should have_selector('form#new_denuncia')
end

Entonces(/^debo visualizar el mensaje "(.*?)"$/) do |msg|
  page.should have_content(msg)
end

Entonces(/^el formulario se debe mostrar vacío$/) do
  field_labeled('Funcionario').value.should be_blank
  field_labeled('Queja').value.should be_blank
  field_labeled('Email').value.should be_blank
end

def rellenar_denuncia
  select 'Contraloría', from: 'Dependencia'
  fill_in 'Funcionario', with: 'Funcionario'
  fill_in 'Queja', with: 'Mi queja'
  fill_in 'Email', with: 'denunciante@mail.com'
end
