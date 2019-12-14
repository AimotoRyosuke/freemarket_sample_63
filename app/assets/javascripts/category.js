$(function(){
  function appendLargeBox(){
    let box = `<ul class='header__container__bottom__category-box__large-box'></ul>`;
    $('.header__container__bottom__category-box').append(box);
  }
  function appendLargeCat(large){
    let cat = `<a href='/items/category/search?category=${large.id}' class='header__container__bottom__category-box__large-box__name' id='${large.id}'>${large.name}</a>`;
    $('.header__container__bottom__category-box__large-box').append(cat);
  }

  $('.header__container__bottom__left__category').on('mouseenter', function(){
    $.ajax({
      type: 'GET',
      url: '/items/large_category',
      dataType: 'json'
    })
    .done(function(largeCategory){
      $('.header__container__bottom__category-box__large-box').remove();
      $('.header__container__bottom__category-box__mid-box').remove();
      $('.header__container__bottom__category-box__small-box').remove();
      appendLargeBox();
      largeCategory.forEach(function(large){
        appendLargeCat(large);
      });
    })
    .fail(function(){
      alert('現在カテゴリー機能は使えません');
    })
  });

  function appendMidBox(){
    let box = `<ul class='header__container__bottom__category-box__mid-box'></ul>`;
    $('.header__container__bottom__category-box').append(box);
  }
  function appendMidCat(mid){
    let cat = `<a href='/items/category/search?category=${mid.id}' class='header__container__bottom__category-box__mid-box__name' id='${mid.id}'>${mid.name}</a>`;
    $('.header__container__bottom__category-box__mid-box').append(cat);
  }

  $(document).on('mouseenter','.header__container__bottom__category-box__large-box__name' ,function(){
    let value = $(this).attr('id')
    $('.header__container__bottom__category-box__large-box__name').css({'background-color': '#fff','color': '#333333'});
    $(this).css({'background-color': '#ea352d', 'color': '#ffffff'});
    $.ajax({
      type: 'GET',
      url: '/items/mid_category',
      dataType: 'json',
      data: {'large_category': value},
    })
    .done(function(midCategory){
      $('.header__container__bottom__category-box__mid-box').remove();
      $('.header__container__bottom__category-box__small-box').remove();
      appendMidBox()
      midCategory.forEach(function(mid){
        appendMidCat(mid);
      });
    })
    .fail(function(){
      console.log('失敗')
    })
  })
  function appendSmallBox(){
    let box = `<ul class='header__container__bottom__category-box__small-box'></ul>`;
    $('.header__container__bottom__category-box').append(box);
  }
  function appendSmallCat(small){
    let cat = `<a href='/items/category/search?category=${small.id}' class='header__container__bottom__category-box__small-box__name id='${small.id}'>${small.name}</a>`;
    $('.header__container__bottom__category-box__small-box').append(cat);
  }

  $(document).on('mouseenter','.header__container__bottom__category-box__mid-box__name' ,function(){
    let value = $(this).attr('id')
    $('.header__container__bottom__category-box__mid-box__name').css({'background-color': '#fff','color': '#333333'});
    $(this).css({'background-color': '#efefef'});
    $.ajax({
      type: 'GET',
      url: '/items/small_category',
      dataType: 'json',
      data: {'mid_category': value},
    })
    .done(function(smallCategory){
      $('.header__container__bottom__category-box__small-box').remove();
      appendSmallBox();
      smallCategory.forEach(function(small){
        appendSmallCat(small);
      });
    })
    .fail(function(){
      console.log('失敗')
    });
  });

  $(document).on('mouseenter','.header__container__bottom__category-box__small-box__name' ,function(){
    $(this).css({'background-color': '#efefef'});
  });

  $('.header__container__bottom__category-box').on('mouseleave','.header__container__bottom__category-box__large-box__name' ,function(){
    if($('ul:hover')[0] != $('.header__container__bottom__category-box__mid-box')[0] || $('.header__container__bottom__category-box__small-box')[0]){
      $(this).css({'background-color': '#fff','color': '#333333'});
    }
  });
  $(document).on('mouseleave','.header__container__bottom__category-box__mid-box__name' ,function(){
    if($('ul:hover')[0] != $('.header__container__bottom__category-box__small-box')[0]){
      $(this).css({'background-color': '#fff'});
    }
  });
  $(document).on('mouseleave','.header__container__bottom__category-box__small-box__name' ,function(){
    $(this).css({'background-color': '#fff'});
  });

  $(document).on('mouseover', function(){
    if($('div:hover')[2] != $('.header__container__bottom__category-box')[0]){
      $('.header__container__bottom__category-box__large-box').remove();
      $('.header__container__bottom__category-box__mid-box').remove();
      $('.header__container__bottom__category-box__small-box').remove();
    }
  });
});