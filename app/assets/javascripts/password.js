$(function(){
  $('#checkbox').on('change', function(){
    if($('#checkbox').prop('checked')){
      let password = $('#user_password').val();
      $('.form__group__show-password:hidden').text(password).css('display','inline-block').fadeIn(1);
    } else {
      $('.form__group__show-password').fadeOut(1);
    }
  })
  $('#user_password').on('keyup', function(){
    if($('#checkbox').prop('checked')){
      let password = $('#user_password').val();
      $('.form__group__show-password').text(password)
    }
  })
})