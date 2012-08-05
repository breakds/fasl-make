(defpackage :fasl-make
  (:use :common-lisp)
  (:export #:main))

(in-package :fasl-make)

(require 'sb-posix)

(defun to-string (sym)
  "convert a symbol to a string"
  (format nil "~a" sym))

(defun main(argv)
  (when (> (length argv) 1)
    ;; search for "makefile.lisp" under directory specified by the first command line argument
    (let ((make-file (merge-pathnames (format nil "~a/" (cadr argv)) "makefile.lisp"))
          (env (make-hash-table :test #'equal)))
      (if (probe-file make-file)
          (progn
            (setf (gethash "PROJECT-DIR" env) (format nil "~a/" (cadr argv)))
            (setf (gethash "BUILD-DIR" env) "build")
            (setf (gethash "TARGETS" env) nil)
            (with-open-file (*standard-input* make-file
                                              :direction :input
                                              :if-does-not-exist nil)
              (loop for exp = (read nil nil 'eof)
                 until (eq exp 'eof)
                 do (cond ((equal (to-string (car exp)) "TARGET") ;; declare compilation targets
                           (let ((current (gethash "TARGETS" env)))
                             (setf (gethash "TARGETS" env) 
                                   (append current (list (rest exp))))))
                          ((eq (car exp) 'print) ;; print values of variables 
                           (let ((var (to-string (cadr exp))))
                             (format t "~a: ~a~%" var (gethash var env))))
                          ((not (cddr exp)) ;; less than two elements in exp, treated as assignment
                           (setf (gethash (to-string (car exp)) env) (cadr exp))))))
            ;;; Start making
            (let ((output-dir (format nil "~a~a/" (gethash "PROJECT-DIR" env) (gethash "BUILD-DIR" env))))
              ;; 1. create directory
              (ensure-directories-exist (merge-pathnames output-dir "fake"))
              ;; 2. iterate over the targets list
              (loop for target in (gethash "TARGETS" env)
                 do 
                   (format t "compiling ~a ...~%" (car target))
                   ;; compile .fasl file
                   (compile-file (merge-pathnames (gethash "PROJECT-DIR" env) (cadr target))
                                 :output-file (merge-pathnames output-dir (format nil "~a.fasl" (car target))))
                   ;; write bash wrapper
                   (with-open-file (out (merge-pathnames output-dir (car target))
                                        :direction :output
                                        :if-exists :supersede)
                     (format out "#!/bin/bash~%")
                     (format out "DIR=$( cd \"$( dirname \"$0\" )\" && pwd )~%")
                     (format out "sbcl --noinform --no-userinit --quit ")
                     (format out "     --eval \"(load \\\"${DIR}/~a.fasl\\\")\" " (car target))
                     (format out "     --eval '(~a::main *posix-argv*)' $@ ~%" (car target)))
                   ;; add executable permission
                   (sb-posix:chmod (merge-pathnames output-dir (car target)) 493))))
          (format t "[fail] ~a does not exist.~%" make-file)))))

      
           

      
                                      
