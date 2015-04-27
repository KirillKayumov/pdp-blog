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

  $(window).scroll ->
    url = $('.pagination.main .next_page').attr('href')
    if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
      $('.pagination.main').text('Fetching more articles...')
      $.getScript(url)
