class CreateDependencies < ActiveRecord::Migration
  def change
    create_table :dependencies do |t|
      t.string :name
      t.string :version_constraint

      t.timestamps null: false
    end
  end
end
