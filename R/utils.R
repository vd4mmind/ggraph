nAngle <- function(x, y, degrees = TRUE) {
    angles <- atan(y/x)
    if (degrees) {
        angles*360/(2*pi)
    } else {
        angles
    }
}
eAngle <- function(x, y, xend, yend, degrees = TRUE) {
    x <- xend - x
    y <- yend - y
    nAngle(x, y, degrees)
}
#' @importFrom scales rescale_mid
mid_rescaler <- function(mid) {
    function(x, to = c(0, 1), from = range(x, na.rm = TRUE)) {
        rescale_mid(x, to, from, mid)
    }
}
manual_scale <- function(aesthetic, values, ...) {
    pal <- function(n) {
        if (n > length(values)) {
            stop("Insufficient values in manual scale. ", n,
                 " needed but only ", length(values), " provided.",
                 call. = FALSE)
        }
        values
    }
    discrete_scale(aesthetic, "manual", pal, ...)
}
#' @importFrom scales zero_range
resolution <- function (x, zero = TRUE) {
    if (is.integer(x) || zero_range(range(x, na.rm = TRUE)))
        return(1)
    x <- unique(as.numeric(x))
    if (zero) {
        x <- unique(c(0, x))
    }
    min(diff(sort(x)))
}