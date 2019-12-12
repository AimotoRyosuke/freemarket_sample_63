$(function(){
  var $category = $('.header__container__bottom__left__category__character')
  var $box1 = $(".header__container__bottom__box1")
  var $box1__child = $(".header__container__bottom__box1__child")
  var $box1__grand__child = $(".header__container__bottom__box1__child__grand-child") 
  $box1.on("mouseleave",function(){
    $box1.hide(1)
    })
    $category.hover(function(){
    $box1.fadeIn(1)
    $box1.hover(function(){
      $box1__child.fadeIn(1).on("mouseover",function(){
        $box1__grand__child.fadeIn(1);
        $box1__child.on("mouseleave",function(){
          $box1__grand__child.fadeOut(1)
          $category.on("mouseover",function(){
            $box1__child.fadeOut(1) 
            $category.on("mouseleave",function(){
              $box1.fadeOut(1)
              
            })
          })
        })
      }); 
    });
  });

});

