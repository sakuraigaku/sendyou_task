# 調理器具
class Equipment
  # 調理器具id
  attr_accessor :id
  # 調理器具名
  attr_accessor :name
  # クラス共通のidカウンター
  @@id=1

  # 調理器具名を登録したあと、クラス共通のidカウンターを1増やすコンストラクタ
  def initialize(name:)
    self.name = name
    self.id = @@id
    @@id+=1
  end

  # 調理器具パラメータ出力
  def info
    puts "{\"id\":#{id},\"name\":\"#{name}\"},"
  end

end