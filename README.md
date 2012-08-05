fasl-make
=========

fasl based sbcl application builder.

fasl-make is a tool written in common lisp that builds executables for your common lisp project. Under the hood, it compiles your lisp program into fasl file, and creates a bash wrapper to run it.

## Documantation

### Installation

run 
```bash
echo you_path_to_quicklisp_setup.lisp > ~/.fasl-make
./boostrap
```
in the project directory of fasl-make. The installation script "bootstrap" will create a "build" directory and place the execulate "fasl-make" in it.

### Usage

- Create makefile.lisp in your project directory.
- In your own project directory, run ```fasl-make .```. You can also use ```fasl-make``` outside your project directory, as long as the path to the project directory is provided as argument to ```fasl-make```.

### Syntax for makefile.lisp

makefile.lisp consists of statements. There are 3 kinds of statements.


- ```lisp (object ...)```. This will add a target for the compilation.



### Dependencies
* fasl-make only works with sbcl. This also means it DEPENDS on sbcl.
* fasl-make requires quicklisp.


