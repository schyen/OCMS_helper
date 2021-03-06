#' cms_palette
#' generates colour palette from RColorBrewer
#'
#' @param n  numeric; default 1. number of colours; cannot exceed 335
#' @param preview logic; default FALSE; when set, gives preview of colour
#' @param palette character; allows you to specify a RColorBrewer palette by name
#' @param full logic; default FALSE; when set, returns all 355 colours
#' @export
#' @return vector of HEX colours, if full set to TRUE, gives all 335 colours, else gives n numbers


cms_palette <- function(n = 1, preview = FALSE, palette = NULL, full = FALSE) {

  # pulling colours from RColorBrewer-------------------------------------------

  # putting all RColorBrewer colours into dataframe
  full_palette <- RColorBrewer::brewer.pal.info
  full_palette$palID <- rownames(full_palette)

  ordered_pal <- rbind(dplyr::filter(full_palette, category == 'qual'),
                       dplyr::filter(full_palette, category == 'div'),
                       dplyr::filter(full_palette, category == 'seq'))

  # subsetting based on number of colours
  if(!is.null(palette)) {
    ordered_pal <- dplyr::filter(ordered_pal, palID %in% palette)
    n <- ordered_pal$maxcolors
  }

  col_vector = unlist(mapply(RColorBrewer::brewer.pal, ordered_pal$maxcolors,
                             ordered_pal$palID))

  col_samp <- col_vector[1:n]

  if(full==TRUE) out <- col_vector
  else out <- col_samp

  if(preview==TRUE) pie(rep(1,n), col=out)

  return(out)
}
