require 'active_record'

module Todo
  # tasksテーブルを表現するモデルクラス
  # @author hirayama
  class Task < ActiveRecord::Base
    NOT_YET = 0 # タスク未完
    DONE    = 1 # タスク完了
    PENDING = 2 # タスク保留

    # ステ名称と数値の組み合わせ
    STATUS = {
      'NOT_YET' => NOT_YET,
      'DONE'    => DONE,
      'PENDING' => PENDING
    }.freeze

    # scope: メソッドチェインであるということを保証する
    # （別のメソッドを組み合わせたalias、と覚えると理解しやすいかも）
    scope :status_is, ->(status) { where(status: status) }

    # validates
    validates :name,    presence:    true, length: {maximum: 140}
    validates :content, presence:    true
    validates :status,  numericality: true, inclusion: {in: STATUS.values}
  end

end
