# 料理
class Dish
  # 料理id
  attr_accessor :id
  # 料理名
  attr_accessor :name
  # 料理の材料
  attr_accessor :ingredients
  # 料理の調理器具
  attr_accessor :equipments
  # クラス共通のidカウンター
  @@id=1

  # 料理名を登録したあと、クラス共通のidカウンターを1増やすコンストラクタ
  def initialize(name:)
    self.name = name
    self.id = @@id
    @@id+=1
  end

  # 料理パラメータ出力
  def info

    ingredients_id_str=""
    ingredients.each_with_index do|ing,count|
      if count != 0
        ingredients_id_str+=","
      end
      ingredients_id_str+=ing.id.to_s
    end

    equipments_id_str=""
    equipments.each_with_index do|equ,count|
      if count != 0
        equipments_id_str+=","
      end
      equipments_id_str+=equ.id.to_s
    end

    puts "{\"id\":#{id},\"name\":\"#{name}\",ingredients:[#{ingredients_id_str}],\"equipments\":[#{equipments_id_str}]},"
  end


end