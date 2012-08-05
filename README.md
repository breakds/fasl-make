fasl-make
=========




## Introduction

fasl based sbcl application builder.

fasl-make is a tool written in common lisp that builds executables for your common lisp project. Under the hood, it compiles your lisp program into fasl file, and creates a bash wrapper to run it. This approach avoids the existence of a large and tedious dumped core.

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


- ```(object keyword-value-pairs)```. This will add a target for the compilation. You can specify the keywoard-value-pairs summarized below:
  <table align="center">
  <tr><td align="center"> <b>keyword</b> </td> <td align="center"> <b> value-type </b> </td>
       <td align="center"> <b> description </b> </td> <td align="center"> <b> required </b> </td> </tr>
  <tr> <td>:srouce </td> <td> string </td> <td> source code file for this compilation rule </td> <td> yes </td> </tr> 
  <tr> <td>:target </td> <td> string </td> <td> target binary for this compilation rule </td> <td> yes </td> </tr> 
  <tr> <td>:quickload </td> <td> list </td> <td> a list of packages that will be loaded by quicklisp </td> <td> no </td> </tr> 
  </table>

- ```(print variable-name)```. This will show the value of a variable in the process of compilation.
- ```(variable-name value)```. This will assign a new value for a variable.

### Special Variables
- project-dir: the project directory of the project to be compiled.
- build-dir: the holder directory for built binaries. (default: project-dir/build)

### Sample makefile.lisp

```lisp
(build-dir "release")
(object :source "something.lisp" :target "something" :quickload (cl-fad))
(print project-dir)
```


### Dependencies
* fasl-make only works with sbcl. This also means it DEPENDS on sbcl.
* fasl-make requires quicklisp.


