program example_terminalite
    use terminalite
    implicit none

    ! Example usage of the colorize subroutine
    call colorize('Hello, World!', 'FF0000', 'FFFFFF', 1)     ! Red text with white background and bold style
    call colorize('This is a test.', '00FF00', '000000', 4)   ! Green text with black background and underlined style
    call colorize('Another example.', '0000FF', 'FFFF00', 7)  ! Blue text with yellow background and inverted style

    ! Example usage of the template subroutine
    call template('[BOLD][FG:F0F0F0]Hello, [BG:FFFFFF]World![RESET]')  ! Bold white text with blue background
    call template('[BOLD][FG:FF0000][BG:FFFFFF]Hello, World![RESET]')  ! Bold red text with white background

end program example_terminalite