#' sw_sum_plot: plot the output of `sw_sum()`
#'
#' @description This function plots the result of `sw_sum()` - both the SPD and
#'   the occurrence of exact felling dates - and adds a smoothing spline to the SPD.
#'
#' @param x The output of `sw_sum()`.
#' @param bar_col The fill color for the bars.
#' @param spline_col The line color of the fitted smoothing spline.
#'
#' @return A ggplot style graph.
#' @export
#'
#' @examples
#' dummy6 <- data.frame(
#' series = c("trs_30", "trs_31", "trs_32", "trs_34", "trs_35", "trs_36",
#' "trs_37", "trs_38", "trs_39"),
#' last = c(1000, 1009, 1007, 1005, 1010, 1020, 1025, 1050, 1035),
#' n_sapwood = c(5, 10, 15, 16, 8, 0, 10, 3, 1),
#' waneyedge = c(FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE)
#' )
#' tmp <- sw_sum(dummy6)
#' sw_sum_plot(tmp, bar_col = "burlywood1")
#'
sw_sum_plot <- function(x, bar_col = "lightblue", spline_col = "tomato3") {

        # to avoid notes in CMD check
        spline <- SPD_wk <- year <- y <- SPD <- SPD_movAv <- NULL


pdf_matrix <- as.data.frame(x)
# pdf_matrix <- subset(pdf_matrix, SPD > 0.0001 & !is.na(SPD)) & !is.na(SPD_wk))
smooth <-
        as.data.frame(
                movAv(pdf_matrix$SPD, 11, align = "center", edges = "fill")
                )
names(smooth) <- "SPD_movAv"
pdf_matrix <- cbind(pdf_matrix, smooth)

spline_int <-
        as.data.frame(
                spline(pdf_matrix$year, pdf_matrix$SPD_movAv, method = "natural")
                )
plot_range <- range(pdf_matrix$year)
p_max <- max(pdf_matrix$SPD)

fd <- pdf_matrix[, c("year", "SPD_wk")]
fd <- subset(fd, SPD_wk>0)
if (nrow(fd) > 0){
        fd <- rep(fd$year, fd$SPD_wk)
        fd <- data.frame(fd)
        names(fd) <- "year"
        fd$y <- 1
        fd <- fd |>
        dplyr::group_by(year) |>
        dplyr::mutate(y = cumsum(y)) |>
        dplyr::left_join(pdf_matrix |> dplyr::select("year", "SPD"), by = "year")
}

p <-
     pdf_matrix |>
        dplyr::select(year, SPD, SPD_movAv) |>
        ggplot2::ggplot() +
        ggplot2::geom_col(ggplot2::aes(x = year, y = SPD),
                          fill = bar_col,
                          alpha = 0.5) +
        ggplot2::geom_line(data = spline_int,
                           ggplot2::aes(x = x, y = y),
                           color = spline_col,
                           size = 1,
                           alpha = .5) +
        { if (nrow(fd) > 0) ggplot2::geom_point(data = fd,
                            ggplot2::aes(x = year, y = SPD + y * p_max/20),
                            size = 3,
                            shape = 8,
                            colour = "navyblue") } +
        ggplot2::scale_x_continuous(
                limits = c(plyr::round_any(plot_range[1], 10, floor),
                           plyr::round_any(plot_range[2], 10, ceiling)),
                breaks = seq(plyr::round_any(plot_range[1], 10, floor),
                             plyr::round_any(plot_range[2], 10, ceiling),
                             20)) +
        ggplot2::theme_minimal()  +
        ggplot2::xlab("calendar year") +
        ggplot2::theme(
                axis.text=ggplot2::element_text(size=10),
                # axis.title.x=ggplot2::element_blank(),
                # axis.title.y=ggplot2::element_blank(),
                # axis.text.y = element_blank(),
                panel.grid.minor.y=ggplot2::element_blank(),
                panel.grid.major.y=ggplot2::element_blank(),
                legend.position = "none"
                )
return(p)
}