$ ->
  $(document).on 'scroll', ->
    if $(window).scrollTop() > 100
      $('.scroll-top-wrapper').addClass('show');
    else
      $('.scroll-top-wrapper').removeClass('show');

  $('.scroll-top-wrapper').on 'click', ->
    $('body').animate(
      scrollTop: 0,
      500
    )
