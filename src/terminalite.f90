! TERMINALITE
! ---------------------------------------------------------
! A simple Fortran module to colorize text in the terminal using numbers
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
!     call terminalite('Hello, World!', 'FF0000', 'FFFFFF', 1)
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

    function hex_to_ansi(hex) result(ansi_code)
        implicit none
        character(len=*), intent(in) :: hex
        integer :: r, g, b
        character(len=20) :: ansi_code

        ! Convert hex to RGB
        read(hex(1:2), '(Z2)') r
        read(hex(3:4), '(Z2)') g
        read(hex(5:6), '(Z2)') b

        ! Create ANSI escape code for 24-bit color
        write(ansi_code, '(A,I0,A,I0,A,I0,A)') char(27)//'[38;2;', r, ';', g, ';', b, 'm'
    end function hex_to_ansi

    function hex_to_bg_ansi(hex) result(ansi_code)
        implicit none
        character(len=*), intent(in) :: hex
        integer :: r, g, b
        character(len=20) :: ansi_code

        ! Convert hex to RGB
        read(hex(1:2), '(Z2)') r
        read(hex(3:4), '(Z2)') g
        read(hex(5:6), '(Z2)') b

        ! Create ANSI escape code for 24-bit background color
        write(ansi_code, '(A,I0,A,I0,A,I0,A)') char(27)//'[48;2;', r, ';', g, ';', b, 'm'
    end function hex_to_bg_ansi
end module utils

subroutine terminalite(text, color_hex, bg_color_hex, style)
    use utils
    implicit none
    character(len=*), intent(in) :: text, color_hex, bg_color_hex
    integer, intent(in) :: style
    character(len=20) :: color_code, bg_color_code

    ! Convert hex to ANSI escape codes
    color_code = hex_to_ansi(color_hex)
    bg_color_code = hex_to_bg_ansi(bg_color_hex)

    ! Print the text with the specified attributes
    write(*, '(A)') char(27)//'['//trim(adjustl(itoa(style)))//'m'//trim(color_code)//trim(bg_color_code)//trim(text)//char(27)//'[0m'
end subroutine terminalite

program terminalite_program
    use utils
    implicit none
    call terminalite('Hello, World!', 'FF0000', 'FFFFFF', 1)  ! Red text with white background and bold style
end program terminalite_program