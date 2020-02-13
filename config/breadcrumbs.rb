# ルート
crumb :root do
  link "トップページ", root_path
end

# マイページ
crumb :mypage do
  link "マイページ", mypage_path
end

# 商品ページ
crumb :product do
  link "商品", root_path
end

# 支払い方法
crumb :card do
  link "支払い方法", mypage_card_path
  parent :mypage
end

# ログアウト
crumb :logout do
  link "ログアウト", mypage_logout_path
  parent :mypage
end