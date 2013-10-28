class CreateDenuncias < ActiveRecord::Migration
  def change
    create_table :denuncias do |t|
      t.string :funcionario
      t.text :queja
      t.string :email
      t.references :dependencia

      t.timestamps
    end
    add_index :denuncias, :dependencia_id
  end
end
