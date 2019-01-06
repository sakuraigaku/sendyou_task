Encoding.default_external = 'utf-8'

require 'csv'
require './cooking'
require './dish'

class Main
  def main
    # 料理リスト
    dish_list = Array.new
    # 材料リスト
    ingredient_list = Array.new
    # 調理器具リスト
    equipment_list = Array.new

    # tableAの処理
    set_csv_data_to_list("tableA.csv", ingredient_list, dish_list)
    # tableBの処理
    set_csv_data_to_list("tableB.csv", equipment_list, dish_list)
    # 回答出力
    answer_output(dish_list,equipment_list,ingredient_list)
  end

  def set_csv_data_to_list(table_path, cooking_list, dish_list)
    id_counter = 0
    table_csv_data = CSV.read(table_path, headers: true)
    table_csv_data.each do |cd|
      # 同じ料理名を料理リストから探す
      dish = name_in_list?(dish_list, cd[0])
      if dish == nil
        dish = Dish.new(name: cd[0])
      end

      # 料理のcookingリスト
      dish_cooking_list = Array.new

      (1..cd.size - 1).each do |i|
        # nilの場合スキップ
        next if cd[i] == nil
        data_list = cd[i].gsub(/[、　／ ]/, ",").split(",")
        data_list.each do |dl|
          # 名前がない場合スキップ
          next if dl == "" || dl == nil

          # cooking_nameがcooking_listの中と被っていない場合、新規のcookingを作成して、cooking_list,dish_cooking_listに追加し、id_counterを1増やす
          # 被っている場合、既存のcookingをdish_cooking_listに追加
          overlap_cooking = name_in_list?(cooking_list, dl)
          if overlap_cooking != nil
            dish_cooking_list.push(overlap_cooking)
          else
            cooking = Cooking.new(id: id_counter += 1, name: dl)
            cooking_list.push(cooking)
            dish_cooking_list.push(cooking)
          end

        end
      end

      if table_path == "tableA.csv"
        dish.ingredients = dish_cooking_list
        dish_list.push(dish)
      else
        dish.equipments = dish_cooking_list
      end

    end

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
  def answer_output(dish_list,ingredient_list,equipment_list)
    puts "{"
    puts "\"dishes\":["
    dish_list.each do |dish|
      puts dish.info
    end
    puts "],"
    puts "\"ingredients\":["
    ingredient_list.each do |ingredient|
      puts ingredient.info
    end
    puts "],"
    puts "\"equipments\":["
    equipment_list.each do |equipment|
      puts equipment.info
    end
    puts "]"
    puts "}"

  end
end

# 実行
Main.new.main




