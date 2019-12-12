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
    // $('#item_price').fadeOut(profit);
    // $('input_normal').val(data);
    
    } else if(data == '') {
    $('.l-right-line').html('');
    $('.l-right-line__bold').html('');
    } else {
    $('.l-right-line').html('');
    $('.l-right-line__bold').html('');
    };
  });
});