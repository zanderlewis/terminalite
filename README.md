# Terminalite
A library for colorizing terminal text in Fortran as part of learning Fortran.

## Usage
1. Include the `terminalite.f90` file in your project.
```toml
[dependencies]
terminalite = { git = "https://github.com/zanderlewis/terminalite" }
```
2. Install the module in your Fortran program.
```bash
fpm build
fpm run
```
3. Use the `terminalite` module in your Fortran program.
```fortran
program terminalite_program
    use utils
    implicit none
    call terminalite('Hello, World!', 31, 47, 1)
end program terminalite_program
```
4. Compile the program
```bash
gfortran -o terminalite_program terminalite_program.f90 terminalite.f90
```
5. Run the program
```bash
./terminalite_program
```
