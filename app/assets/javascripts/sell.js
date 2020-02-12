$(document).on('turbolinks:load', ()=> {
  // 画像用のinputを生成する関数
  const buildFileField = (num)=> {
    const html = `<div data-index="${num}" class="js-file_group2">
                    <input class="js-file" type="file"
                    name="product[images_attributes][${num}][image]"
                    id="product_images_attributes_${num}_image"><br>
                  </div>`;
    return html;
  }
  // プレビュー用のimgタグを生成する関数
  const buildImg = (index, url)=> {
    const html = `<div class='preview-files'>
                    <div class='preview-file'>
                      <img data-index="${index}" src="${url}" class="preview-file-img">
                    </div>
                    <div data-index="${index}" class="js-remove">削除</div>
                  </div>`;
    return html;
  }

  // file_fieldのnameに動的なindexをつける為の配列
  let fileIndex = [1,2,3,4,5,6,7,8,9,10];
  // 既に使われているindexを除外
  lastIndex = $('.js-file_group:last').data('index');
  fileIndex.splice(0, lastIndex);

  $('.hidden-destroy').hide();

  $('#image-box').on('change', '.js-file', function(e) {
    const targetIndex = $(this).parent().data('index');
    // ファイルのブラウザ上でのURLを取得する
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);

    // 該当indexを持つimgがあれば取得して変数imgに入れる(画像変更の処理)
    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('image', blobUrl);
    } else {  // 新規画像追加の処理
      $('#previews').append(buildImg(targetIndex, blobUrl));
      // fileIndexの先頭の数字を使ってinputを作る
      $('#image-box').append(buildFileField(fileIndex[0]));
      fileIndex.shift();
      // 末尾の数に1足した数を追加する
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
    }
  });

  $('.js-file_group:first').on('click', function() {
    $('.js-file:last').trigger('click');
    return false;
  });

  $('#image-box').on('click', '.js-remove', function() {
    const targetIndex = $(this).parent().data('index');
    // 該当indexを振られているチェックボックスを取得する
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    // もしチェックボックスが存在すればチェックを入れる
    if (hiddenCheck) hiddenCheck.prop('checked', true);

    $(this).parent().remove();
    $(`img[data-index="${targetIndex}"]`).remove();
    
    var number = Number($(this).data('index'));
    
    const upload_btn = $(`#product_images_attributes_${number}_image`);
    if(upload_btn) upload_btn.remove(); // アップロードボタンが存在すれば削除
    

    // 画像入力欄が0個にならないようにしておく
    if ($('.js-file').length == 0) $('#image-box').append(buildFileField(fileIndex[0]));
  });

  $(function() {
    // 販売利益の計算
    $('.price-flex__input').keyup(function() {
      let price = $(this).val();
      if(price >= 300) {
        let fee = price * 0.10;
        let resultFee = Math.floor(fee)
        $('.result-fee').text(`${resultFee}円`);
  
        let profit = price - resultFee;
        $('.result-profit').text(`${profit}円`);
      }
    });
  });

  // 出品ページのフォームにバリデーションをかける
  $(function(){
    //form指定
    $('.formsample').validate({
      //バリデーション、ルール設定
      rules: {
        "product[images_attributes][0][image]": { //画像
          required: true, //入力必須
        },
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
        }
      },
      //エラーメッセージ設定
      messages: {
        "product[images_attributes][0][image]": { //画像
          required: '画像がありません'
        },
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
        }

      },
      //エラーメッセージ出力場所設定
      errorPlacement: function(error, element){
        console.log(error);
        console.log(element);
        // alert("hello");
        // 画像と商品価格に関してのエラー文はデフォルトだと変な場所に出力される。その為場所を指定している。
        if(element.attr("name")=="product[images_attributes][0][image]")
        {
          error.insertAfter(".l-single-head");	
        }
        else if(element.attr("name")=="product[price]")
        {
          error.insertAfter(".price_error");	
        }
        else{
          error.insertAfter(element);	
        }
      }
    });
  });
});

