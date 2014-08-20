class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :body
      t.timestamps
    end

    create_table :choices do |t|
      t.belongs_to :question
      t.string :option
      t.integer :value
      t.timestamps
    end
  end
end
