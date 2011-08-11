class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.integer :user_id
      t.integer :stack_id
      t.integer :choice_id

      t.timestamps
    end
    add_index :answers, :user_id
    add_index :answers, :stack_id
  end

  def self.down
    drop_table :answers
  end
end
