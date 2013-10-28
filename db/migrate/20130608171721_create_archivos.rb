class CreateArchivos < ActiveRecord::Migration
  def change
    create_table :archivos do |t|
      t.references :denuncia
      t.string :adjunto

      t.timestamps
    end
    add_index :archivos, :denuncia_id
  end
end
