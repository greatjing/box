class AddRowOrderToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :row_order, :integer

    # 为event中row_order没有值的赋值
    Event.find_each do |e|
      e.update( :row_order_position => :last )
    end

    add_index :events, :row_order

  end
end
