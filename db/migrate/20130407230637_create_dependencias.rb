class CreateDependencias < ActiveRecord::Migration
  def change
    create_table :dependencias do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
