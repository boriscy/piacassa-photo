class @PicassaAdPhoto
  constructor: (elem)->
    @url = elem.href.replace(/alt=rss/, 'alt=json')
    @pos = $(elem).position()

    $('#ad-gallery-container').on('click', 'a.close', -> $('#ad-gallery-container').hide())
  createGallery: ->
    $.getJSON(@url, (resp)=>
      @createHTML(resp)
    )
  createHTML: (data)->
    photos = data.feed.entry

    arr = ['<a href="javascript:" class="close" title="Cerrar"></a>',
      '<div class="ad-gallery"><div class="ad-image-wrapper"></div><div class="ad-controls"></div>',
    '<div class="ad-nav"><div class="ad-thumbs"><ul class="ad-thumb-list">']

    for photo in photos

      arr.push ['<li>', "<a href='#{photo.content.src}'>", 
        @createImage(photo),
        "</a>", '</li>'].join('')

    arr.push('</ul></div></div></div></div>')

    $('#ad-gallery-container').html( arr.join('') ).show().css({top: @pos.top - 200, left: @pos.left})
    $('.ad-gallery').adGallery(
      loader_image: 'css/loader.gif'
      start_at_index: 0
      slideshow:
        start_label: 'Iniciar'
        stop_label: 'Parar'
    )

  createImage: (photo)->
    media = photo.media$group
    thumb = media.media$thumbnail[0].url

    if media.media$description.$t == ''
      "<img src ='#{thumb}' />"
    else
      "<img src ='#{thumb}' title='#{media.media$description.$t}' />"

