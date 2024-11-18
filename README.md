# Terminalite
A library for colorizing terminal text in Fortran.

## Usage
1. Include the `terminalite.f90` file in your project.
```toml
[dependencies]
terminalite = { git = "https://github.com/zanderlewis/terminalite" }
```
2. Use the `terminalite` module in your Fortran program.
```fortran
program terminalite_program
    use utils
    implicit none
    call colorize('Hello, World!', 'FF0000', 'FFFFFF', 1)  ! Red text with white background and bold style
    ! Or, you can use template strings
    call template('[BOLD][FG:FF0000][BG:FFFFFF]Hello, World![RESET]')
end program terminalite_program
```
3. Compile the program
```bash
fpm build
```
4. Run the program
```bash
fpm run
```
