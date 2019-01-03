Encoding.default_external = 'utf-8'

require 'csv'
require './equipment'
require './ingredient'
require './dish'


dish_list = Array.new
ingredient_list = Array.new
equipment_list = Array.new

# tableAの処理
tableA_csv_data = CSV.read('tableA.csv', headers: true)
tableA_csv_data.each do |cd|
  # 料理
  dish = Dish.new(name: cd[0])

  # 料理の材料リスト
  dish_ingredient_list = Array.new

  # セルの中身を整形して分割する
  ingredient_data_list = cd[1].gsub(/[、　／ ]/, ",").split(",")

  ingredient_data_list.each do |idl|
    # 材料名がない場合スキップ
    if idl == ""
      next
    end

    # 材料名が被っていいない場合、新規の材料を作成して、材料リスト、料理の材料リストに追加
    # 被っている場合、既存の材料を料理の材料リストに追加
    catch(:break_loop) do
      ingredient_list.each do |il|
        if il.name == idl
          dish_ingredient_list.push(il)
          throw(:break_loop)
        end
      end
      ingredient = Ingredient.new(name: idl)
      ingredient_list.push(ingredient)
      dish_ingredient_list.push(ingredient)
    end
  end

  dish.ingredients = dish_ingredient_list
  dish_list.push(dish)
end


#   tableBの処理
tableB_csv_data = CSV.read('tableB.csv', headers: true)
tableB_csv_data.each do |cd|

  # 同じ料理名を料理リストから探す
  dish = nil
  dish_list.each do |dl|
    if dl.name == cd[0]
      dish = dl
      break
    end
  end

  #   料理の調理器具リスト
  dish_equipment_list = Array.new

  # 調理器具1~3をそれぞれ取り出す
  (1..3).each do |i|
    equipment_data = cd[i]

    if equipment_data == nil
      next
    end

    # 調理器具名が被っていない場合、新規の調理器具を作成して、調理器具リスト、調理器具の材料リストに追加
    # 被っている場合、既存の調理器具を料理の調理器具リストに追加
    catch(:break_loop) do
      equipment_list.each do |del|
        if del.name == equipment_data
          dish_equipment_list.push(del)
          throw(:break_loop)
        end
      end
      equipment = Equipment.new(name: equipment_data)
      equipment_list.push(equipment)
      dish_equipment_list.push(equipment)
    end
  end

  dish.equipments = dish_equipment_list

end

# 回答出力
puts "{"
puts "\"dishes\":["
dish_list.each do |dish|
  dish.info
end
puts "],"
puts "\"ingredients\":["
ingredient_list.each do |ingredient|
  ingredient.info
end
puts "],"
puts "\"equipments\":["
equipment_list.each do |equipment|
  equipment.info
end
puts "]"
puts "}"



