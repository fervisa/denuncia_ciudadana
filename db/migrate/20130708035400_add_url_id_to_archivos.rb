class AddUrlIdToArchivos < ActiveRecord::Migration
  def change
    add_column :archivos, :url_id, :string
    add_index :archivos, :url_id
  end
end
