$(function(){
  // ここから販売利益と手数料の表示
  $('#item_price').on('keyup', function(){ 
    var data = $('#item_price').val();
    
    if ((data >= 300) && (data <= 9999999)) {
    var profit = Math.ceil(data * 0.9);
    
    var fee = (data - profit);
    $('.l-right-line').html(fee);
    $('.l-right-line').prepend('¥');
    $('.l-right-line__bold').html(profit);
    $('.l-right-line__bold').prepend('¥');
    $('input_normal').val(data);
    }
    else if(data == '') {
    // console.log(999);
    $('.l-right-line_bold').html('');
    $('.l-right-line').html('');
    
    }
  
    else if ((data >= 300) && (data >= 9999999)) {
    $('.l-right-line').html('');
    $('.l-right-line__bold').html('');
    
    }
  });
  $('.slider').slick({
    autoplay:true,
    autoplaySpeed:4000,
    dots:true,
  });

  //カテゴリーのセレクト機能追加

  function appendMidSelect() {
    var select_tag = `<div class="select-enclose mid-category">
    <i class="icon-rod-bottom"></i>
    <select class="select-normal" name="item[mid_id]" id="item_mid_id"><option value="">---</option></select>
    </div>`
    $('.add-box').append(select_tag);
  }

  function appendSmallSelect() {
    var select_tag = `<div class="select-enclose small-category">
    <i class="icon-rod-bottom"></i>
    <select class="select-normal" name="item[category_id]" id="item_small_id"><option value="">---</option></select>
    </div>`
    $('.add-box').append(select_tag);
  }

  function appendMidOption(mid) {
    var midOption = `<option value="${mid.id}">${mid.name}</option>`
    $('#item_mid_id').append(midOption)
  }

  function appendSmallOption(small) {
    console.log(small)
    var smallOption = `<option value="${small.id}">${small.name}</option>`
    $('#item_small_id').append(smallOption)
  }


  $('.large-category').change(function(){
    let value = $('#item_large_id').val();
    $.ajax({
      type: 'GET',
      url: '/items/mid_category',
      data: {'large_category' :value},
      dataType: 'json'
    })
    .done(function(midCategory){
      console.log(midCategory)
      $('.mid-category').remove();
      appendMidSelect()
      midCategory.forEach(function(mid){
        appendMidOption(mid);
      })
    })
    .fail(function(){
      alert('error');
    });
  });

  $(document).on('change', '.mid-category', function(){
    let value = $('#item_mid_id').val();
    console.log(value);
    $.ajax({
      type: 'GET',
      url: '/items/small_category',
      data: {'mid_category' :value},
      dataType: 'json'
    })
    .done(function(smallCategory){
      console.log(smallCategory)
      $('.small-category').remove();
      appendSmallSelect()
      smallCategory.forEach(function(small){
        appendSmallOption(small);
      })
    })
    .fail(function(){
      alert('error');
    });

  });
});