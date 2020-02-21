$(document).on('turbolinks:load', ()=> {
  // 画像用のinputを生成する関数
  const buildFileField2 = (num)=> {
    const html = `<div data-index="${num}" class="js-file_group4">
                    <input class="js-file2" type="file"
                    name="product[images_attributes][${num}][image]"
                    id="product_images_attributes_${num}_image"><br>
                  </div>`;
    return html;
  }
  // プレビュー用のimgタグを生成する関数
  const buildImg2 = (index, url)=> {
    const html = `<li class="adsaf">
                    <img data-index="${index}" src="${url}" class="edit_img_${index}">
                    <div data-index="${index}" class="js-remove" name="[edit_remove][${index}]">削除</div>
                  </li>
                  <input data-index="${index}" value="0" class="delete_img_${index}" type="hidden" name="product[images_attributes][${index}][_destroy]" id="product_images_attributes_${index}__destroy">`;
    return html;
  }

  // file_fieldのnameに動的なindexをつける為の配列
  let fileIndex2 = [1,2,3,4,5,6,7,8,9,10];
  // 既に使われているindexを除外
  lastIndex2 = $('.js-file_group3:last').data('index');
  fileIndex2.splice(0, lastIndex2);

  $('.hidden-destroy').hide();

  $('#image-box2').on('change', '.js-file2', function(e) {
    const targetIndex2 = $(this).parent().data('index');
    // ファイルのブラウザ上でのURLを取得する
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);

    // 該当indexを持つimgがあれば取得して変数imgに入れる(画像変更の処理)
    if (img2 = $(`img[data-index="${targetIndex2}"]`)[0]) {
      img2.setAttribute('image', blobUrl);
    } else {  // 新規画像追加の処理
      $('#previews2').append(buildImg2(targetIndex2, blobUrl));
      // fileIndexの先頭の数字を使ってinputを作る
      $('#image-box2').append(buildFileField2(fileIndex2[0]));
      fileIndex2.shift();
      // 末尾の数に1足した数を追加する
      fileIndex2.push(fileIndex2[fileIndex2.length - 1] + 1);
    }
  });

  $('.js-file_group3:first').on('click', function() {
    $('.js-file2:last').trigger('click');
    return false;
  });

  $('#image-box2').on('click', '.js-remove', function() {
    var number = Number($(this).data('index'));
    //削除ボタンを押すと該当の画像が消える
    const edit_img_btn = $(`.edit_img_${number}`);
    if(edit_img_btn) edit_img_btn.remove();
    //削除ボタンを押すと削除ボタンの表記が消える
    $(this).parent().remove();
    //削除ボタンを押すと該当のinputfileが消える
    const file_field_btn = $(`#product_images_attributes_${number}_image`);
    if(file_field_btn) file_field_btn.remove(); // アップロードボタンが存在すれば削除
    //_destoryのvalue0を1に変える
    $(`.delete_img_${number}`).val('1');

    // 画像入力欄が0個にならないようにしておく
    if ($('.js-file2').length == 0) $('#image-box2').append(buildFileField2(fileIndex2[0]));
  });

  //販売価格表示されていたら販売手数料と販売利益が表示される
  $(document).ready(function() {
    let price2 = Number($('.price-flex__input').val());
    if(price2 >= 300) {
      let fee2 = price2 * 0.10;
      let resultFee2 = Math.floor(fee2)
      $('.result-fee').text(`${resultFee2}円`);
      let profit2 = price2 - resultFee2;
      $('.result-profit').text(`${profit2}円`);
    }
  });

  $(document).ready(function(){    
    $.validator.setDefaults({
        ignore: []
    });
  });

  // 出品ページのフォームにバリデーションをかける
  $(function(){
    //form指定
    $('.formsample2').validate({
      //バリデーション、ルール設定
      rules: {
        "product[name]": { //商品名
          required: true, //入力必須
          maxlength: 40 //40文字以内
        },
        "product[description]": { //商品説明
          required: true, //入力必須
          maxlength: 1000 //1000文字以内
        },
        "product[price]": { //商品価格
          required: true, //入力必須
          number: true, //整数限定
          range: [300, 9999999] //300以上9999999以内
        },
        "product[category_id]": { //
          required: true, //入力必須
        },
        "product[status_id]": { //
          required: true, //入力必須
        },
        "product[delivery_charge_id]": { //
          required: true, //入力必須
        },
        "product[ship_from_id]": { //
          required: true, //入力必須
        },
        "product[delivery_days_id]": { //
          required: true, //入力必須
        }
      },
      //エラーメッセージ設定
      messages: {
        "product[name]": { //商品名
          required: '入力してください',
          maxlength: '40文字以内で入力してください'
        },
        "product[description]": { //商品説明
          required: '入力してください',
          maxlength: '1000文字以内で入力してください'
        },
        "product[price]": { //商品価格
          required: '300以上9,999,999以下で入力してください',
          number: '300以上9,999,999以下で入力してください',
          range: '300以上9,999,999以下で入力してください'
        },
        "product[category_id]": { //
          required: 'カテゴリーを選択してください'
        },
        "product[status_id]": { //
          required: '商品の状態を選択してください'
        },
        "product[delivery_charge_id]": { //
          required: '配送料の負担を選択してください'
        },
        "product[ship_from_id]": { //
          required: '発送元の地域を選択してください'
        },
        "product[delivery_days_id]": { //
          required: '発送までの日数を選択してください'
        }
      },
      //エラーメッセージ出力場所設定
      errorPlacement: function(error, element){
        // 画像と商品価格に関してのエラー文はデフォルトだと変な場所に出力される。その為場所を指定している。
        if(element.attr("name")=="product[price]")
        {
          error.insertAfter(".price_error");	
        }
        else if(element.attr("name")=="product[category_id]")
        {
          error.insertAfter(".error-categories");	
        }
        else{
          error.insertAfter(element);	
        }
      }
    });
  });
});

