# encoding: UTF-8

Cuando(/^visito la página de inicio$/) do
  visit root_path
end

Entonces(/^debo visualizar el enlace "(.*?)"$/) do |msg|
  page.should have_link(msg)
end
