fasl-make
=========

fasl based sbcl application builder.

fasl-make is a tool written in common lisp that builds executables for your common lisp project.

## Documantation

### Installation

run 
```bash
echo you_path_to_quicklisp_setup.lisp > ~/.fasl-make
./boostrap
```
in the project directory. The installation script "bootstrap" will create a "build" directory and place the execulate "fasl-make" in it.

### Usage

- Create makefile.lisp in your project directory.
- In your project directory, run ```fasl-make .```. You can also use ```fasl-make``` outside your project directory, as long as the path to the project directory is provided as argument to ```fasl-make```.


### Dependencies
* fasl-make only works with sbcl. This also means it DEPENDS on sbcl.
* fasl-make requires quicklisp.


