! TERMINALITE
! ---------------------------------------------------------
! A simple Fortran module to colorize text in the terminal
! Author: Zander Lewis
! License: MIT
! Repository: https://github.com/zanderlewis/terminalite
! Initial Release: 2024-08-19 (YYYY-MM-DD)
! ---------------------------------------------------------
! Code Explanation
! ---------------------------------------------------------
! This module contains a subroutine that takes in a string
! of text, a color, a background color, and a style, and
! prints the text in the terminal with the specified
! attributes. The color, background color, and style are
! specified using integers, and the subroutine converts
! these integers to the appropriate ANSI escape codes to
! apply the attributes to the text. The subroutine uses the
! itoa function to convert the integers to strings, and then
! concatenates the strings to form the ANSI escape code.
! ---------------------------------------------------------
! Usage
! ---------------------------------------------------------
! To use the terminalite module, simply call the
! terminalite subroutine with the desired text, color,
! background color, and style. The color, background color,
! and style are specified using integers, and the available
! options are defined as parameters in the subroutine.
! ---------------------------------------------------------
! Example
! ---------------------------------------------------------
! The following example demonstrates how to use the
! terminalite module to print "Hello, World!" in red text
! with a white background and bold style.
! ---------------------------------------------------------
! program terminalite_program
!     use terminalite
!     implicit none
!     call terminalite('Hello, World!', 31, 47, 1)
! end program terminalite_program
! ---------------------------------------------------------

module utils
    implicit none
contains
    function itoa(i) result(str)
        implicit none
        integer, intent(in) :: i
        character(len=20) :: str
        write(str, '(I0)') i
        str = adjustl(str)
    end function itoa
end module utils

subroutine terminalite(text, color, bg_color, style)
    use utils
    implicit none
    character(len=*), intent(in) :: text
    integer, intent(in) :: color, bg_color, style
    ! Color variables
    integer, parameter :: black = 30, red = 31, green = 32, yellow = 33, blue = 34, magenta = 35, cyan = 36, white = 37
    ! Background color variables
    integer, parameter :: bg_black = 40, bg_red = 41, bg_green = 42, bg_yellow = 43, bg_blue = 44, bg_magenta = 45, bg_cyan = 46, bg_white = 47
    ! Text style variables
    integer, parameter :: bold = 1, underline = 4, blink = 5, reverse = 7, conceal = 8
    ! Reset all attributes
    integer, parameter :: reset = 0

    ! Convert the integers to strings
    write(*, '(A)') char(27)//'['//trim(adjustl(itoa(style)))//';'//trim(adjustl(itoa(color)))//';'//trim(adjustl(itoa(bg_color)))//'m'//trim(text)//char(27)//'[0m'
end subroutine terminalite

program terminalite_program
    use utils
    implicit none
    call terminalite('Hello, World!', 31, 47, 1)
end program terminalite_program