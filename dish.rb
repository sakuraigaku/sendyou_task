# 料理
class Dish < Cooking
  # 料理の材料
  attr_accessor :ingredients
  # 料理の調理器具
  attr_accessor :equipments
  @@id_counter=0

  def initialize(name:)
    super(id: @@id_counter+=1,name: name)
  end

  # 料理パラメータ出力
  def info
    return "{\"id\":#{id},\"name\":\"#{name}\",ingredients:[#{get_list_in_id(ingredients)}],\"equipments\":[#{get_list_in_id(equipments)}]},"
  end

  # リストの中のオブジェクトのidをカンマ区切りで返す
  def get_list_in_id(list)
    id_str = ""
    list.each_with_index do |l,i|
      if i != 0
        id_str+=","
      end
      id_str+=l.id.to_s
    end
    return id_str
  end
end