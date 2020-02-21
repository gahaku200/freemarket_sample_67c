$(function(){
  $(".product_images").click(function() {
    $(".product_images_top").attr("src", $(this).attr('src'));
  });
});