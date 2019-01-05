Encoding.default_external = 'utf-8'

require 'csv'
require './cooking'
require './dish'

class Main
  def initialize
    # 料理リスト
    @dish_list = Array.new
    # 材料リスト
    @ingredient_list = Array.new
    # 調理器具リスト
    @equipment_list = Array.new
    # 料理idカウンター
    @dish_id_counter = 0
    # 材料idカウンター
    @ingredient_id_counter = 0
    # 料理道具idカウンター
    @equipment_id_counter = 0
  end
  def main
    # tableAの処理
    table_a_csv_data = CSV.read('tableA.csv', headers: true)
    table_a_csv_data.each do |cd|
      # 料理
      dish = Dish.new(id:@dish_id_counter+=1, name: cd[0])

      # 料理の材料リスト
      dish_ingredient_list = Array.new

      # セルの中身を整形して分割する
      ingredient_data_list = cd[1].gsub(/[、　／ ]/, ",").split(",")

      ingredient_data_list.each do |idl|
        # 材料名がない場合スキップ
        next if idl == ""

        # 材料名が被っていいない場合、新規の材料を作成して、材料リスト、料理の材料リストに追加
        # 被っている場合、既存の材料を料理の材料リストに追加
        overlap_ingredient = name_in_list?(@ingredient_list, idl)
        if overlap_ingredient
          dish_ingredient_list.push(overlap_ingredient)
        else
          ingredient = Cooking.new(id: @ingredient_id_counter+=1, name: idl)
          @ingredient_list.push(ingredient)
          dish_ingredient_list.push(ingredient)
        end

      end

      dish.ingredients = dish_ingredient_list
      @dish_list.push(dish)
    end


#   tableBの処理
    table_b_csv_data = CSV.read('tableB.csv', headers: true)
    table_b_csv_data.each do |cd|

      # 同じ料理名を料理リストから探す
      dish = name_in_list?(@dish_list,cd[0])

      #   料理の調理器具リスト
      dish_equipment_list = Array.new

      # 調理器具1~3をそれぞれ取り出す
      (1..3).each do |i|
        equipment_data = cd[i]

        next if equipment_data == nil

        # 調理器具名が被っていない場合、新規の調理器具を作成して、調理器具リスト、調理器具の材料リストに追加
        # 被っている場合、既存の調理器具を料理の調理器具リストに追加
        overlap_equipment = name_in_list?(@equipment_list, equipment_data)
        if overlap_equipment
          dish_equipment_list.push(overlap_equipment)
        else
          ingredient = Cooking.new(id: @equipment_id_counter+=1, name: equipment_data)
          @equipment_list.push(ingredient)
          dish_equipment_list.push(ingredient)
        end
      end

      dish.equipments = dish_equipment_list

    end
    answer_output
  end


# 同じ名前を持ったオブジェクトがリストの中に存在するか,
# 存在するならリストの中身を返す
  def name_in_list?(list, name)
    return nil if list == nil
    list.each do |object|
      return object if object.name == name
    end
    return nil
  end

# 回答出力
  def answer_output
    puts "{"
    puts "\"dishes\":["
    @dish_list.each do |dish|
      puts dish.info
    end
    puts "],"
    puts "\"ingredients\":["
    @ingredient_list.each do |ingredient|
      puts ingredient.info
    end
    puts "],"
    puts "\"equipments\":["
    @equipment_list.each do |equipment|
      puts equipment.info
    end
    puts "]"
    puts "}"

  end
end

# 実行
Main.new.main




