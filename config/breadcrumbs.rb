# ルート
crumb :root do
  link "トップページ", root_path
end

# マイページ
crumb :mypage do
  link "マイページ", mypage_index_path
end

# 商品ページ
crumb :product do
  link "商品", root_path
end

# 出品した商品
crumb :exhibited do
  link "出品した商品"
  parent :mypage
end

# 支払い方法
crumb :card do
  link "支払い方法", card_mypage_index_path
  parent :mypage
end

# ログアウト
crumb :logout do
  link "ログアウト", logout_mypage_index_path
  parent :mypage
end

# クレジットカード情報一覧
crumb :credit do
  link "クレジットカード情報一覧"
  parent :card
end