# frozen_string_literal: true

class DropMenuItem < ActiveRecord::Migration[7.1]
  def change
    drop_table :menu_items
  end
end
