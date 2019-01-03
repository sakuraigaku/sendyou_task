# 材料
class Ingredient
  # 材料id
  attr_accessor :id
  # 材料名
  attr_accessor :name
  # クラス共通のidカウンター
  @@id=1

  # 材料名を登録したあと、クラス共通のidカウンターを1増やすコンストラクタ
  def initialize(name:)
    self.name = name
    self.id = @@id
    @@id+=1
  end

  # 材料パラメータ出力
  def info
    puts "{\"id\":#{id},\"name\":\"#{name}\"},"
  end

end