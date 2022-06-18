# Todo メッセージはconfig/locale/ja.ymlに入れたい
# Todo モデルの要素の表示加工なのでdecoratorに入れたい
module NoticesHelper
  # Todo n+1問題起こるのでinner joinしたい
  def notice_similar_message(notice)
    notice.similars.present? ? "、他#{notice.similars.size}名" : ""
  end

  def notice_message(notice)
    if notice.first_login?
      "初回ログインありがとうございます。"
    else
      "#{notice.follower_name}さん#{notice_similar_message(notice)}にフォローされました。"
    end
  end
end
