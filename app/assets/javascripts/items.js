$(function(){
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
    // debugger;
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
});