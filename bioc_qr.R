bioc_qr <- function(url, width = 800, logo_path = "./bioconductor_logo_rgb.svg") {
  qrsvg <- tempfile(fileext = ".svg")
  qrcode::generate_svg(qrcode::qr_code(url), qrsvg, show =F)
  qr <- magick::image_transparent(magick::image_read_svg(qrsvg, width = width), "white", 50)
  logo <- magick::image_read_svg(logo_path, width = ceiling(width * 1.3))

  crop_str <- sprintf("%dx%d+%d+%d", 
    ceiling(width * 0.85), 
    ceiling(width * 0.85),
    ceiling(width * 0.075),
    ceiling(width * 0.075)
  )
  offset_str <- sprintf("+%d+%d", width * 0.3, width * 0.38)
  magick::image_composite(
    logo, magick::image_crop(qr, crop_str, repage = T),
    operator = "Overlay", offset = offset_str
  )
}

#  bioc_qr("https://www.bioconductor.org/packages/release/bioc/html/FLAMES.html", width = 1000) |> magick::image_write(format='png' , path='./flames_bioc.png')
