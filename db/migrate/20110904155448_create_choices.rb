class CreateChoices < ActiveRecord::Migration
  def self.up
    create_table :choices do |t|
      t.integer :stack_id
      t.string :choice_text
      t.boolean :choice_default
      t.string :choice_sort_order

      t.timestamps
    end
    add_index :choices, :stack_id
  end

  def self.down
    drop_table :choices
  end
end
