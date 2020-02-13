# ルート
crumb :root do
  link "トップページ", root_path
end

# マイページ
crumb :mypage do
  link "マイページ", mypage_path
end

# 支払い方法
crumb :card do
  link "プロフィール", edit_user_path
  parent :mypage
end