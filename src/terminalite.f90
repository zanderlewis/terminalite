module terminalite
    implicit none
    public :: colorize, template
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

    subroutine colorize(text, color_hex, bg_color_hex, style)
        implicit none
        character(len=*), intent(in) :: text, color_hex, bg_color_hex
        integer, intent(in) :: style
        character(len=20) :: color_code, bg_color_code

        ! Convert hex to ANSI escape codes
        color_code = hex_to_ansi(color_hex)
        bg_color_code = hex_to_bg_ansi(bg_color_hex)

        ! Print the text with the specified attributes
        write(*, '(A)') char(27)//'['//trim(adjustl(itoa(style)))//'m'//trim(color_code)//trim(bg_color_code)//trim(text)//char(27)//'[0m'
    end subroutine colorize

    subroutine template(string)
        use, intrinsic :: iso_fortran_env
        implicit none
        character(len=*), intent(in) :: string
        character(len=20) :: color_code, bg_color_code
        integer :: i, tag_end
        character(len=:), allocatable :: tag
    
        i = 1
        do while (i <= len(string))
            if (string(i:i) == '[') then
                tag_end = index(string(i+1:), ']')
                if (tag_end > 0) then
                    tag = adjustl(string(i+1:i+tag_end))
                    select case (tag)
                        case ('BOLD')
                            write(*, '(A)', advance='no') char(27)//'[1m'
                        case ('ITALIC')
                            write(*, '(A)', advance='no') char(27)//'[3m'
                        case ('UNDERLINE')
                            write(*, '(A)', advance='no') char(27)//'[4m'
                        case ('STRIKETHROUGH')
                            write(*, '(A)', advance='no') char(27)//'[9m'
                        case ('RESET')
                            write(*, '(A)', advance='no') char(27)//'[0m'
                        case default
                            if (len(tag) > 2 .and. tag(1:2) == 'FG') then
                                color_code = hex_to_ansi(tag(4:))
                                write(*, '(A)', advance='no') trim(color_code)
                            else if (len(tag) > 2 .and. tag(1:2) == 'BG') then
                                bg_color_code = hex_to_bg_ansi(tag(4:))
                                write(*, '(A)', advance='no') trim(bg_color_code)
                            end if
                    end select
                    i = i + tag_end + 1
                else
                    i = i + 1
                end if
            else
                write(*, '(A)', advance='no') string(i:i)
                i = i + 1
            end if
        end do
        write(*, '(A)') char(27)//'[0m'  ! Reset at the end
    end subroutine template
end module terminalite