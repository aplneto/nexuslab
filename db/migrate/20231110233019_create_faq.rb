class CreateFaq < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.text :faq
      t.text :answer
    end    
  end
end
