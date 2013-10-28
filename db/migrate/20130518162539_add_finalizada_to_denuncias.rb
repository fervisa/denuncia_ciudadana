class AddFinalizadaToDenuncias < ActiveRecord::Migration
  def change
    add_column :denuncias, :finalizada, :boolean
  end
end
