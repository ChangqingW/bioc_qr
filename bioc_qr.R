bioc_qr <- function(url, fig_width = 600,
                    logo_path = "https://raw.githubusercontent.com/ChangqingW/bioc_qr/main/bioconductor_logo_rgb.svg") {
  qrsvg <- tempfile(fileext = ".svg")
  qrcode::generate_svg(qrcode::qr_code(url), qrsvg, show = F, background = 'none')
  qr <-magick::image_read_svg(qrsvg, width = ceiling(fig_width / 1.3))
  logo <- magick::image_read_svg(logo_path, width = fig_width)

  offset_str <- sprintf("+%d+%d", ceiling(fig_width * 0.2), ceiling(fig_width * 0.25))
  magick::image_composite(
    logo, qr,
    operator = "Overlay", offset = offset_str
  )
}

#  bioc_qr("https://www.bioconductor.org/packages/release/bioc/html/FLAMES.html", fig_width = 1000) |> magick::image_write(format='png' , path='./flames_bioc.png')
