;;;;
;;;; $Id: psd-sci.scm,v 1.5 1993/10/06 13:04:28 pk Exp $
;;;;
;;;; psd -- a portable Scheme debugger, version 1.1
;;;; Copyright (C) 1992 Pertti Kellomaki, pk@cs.tut.fi

;;;; This program is free software; you can redistribute it and/or modify
;;;; it under the terms of the GNU General Public License as published by
;;;; the Free Software Foundation; either version 1, or (at your option)
;;;; any later version.

;;;; This program is distributed in the hope that it will be useful,
;;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;;;; GNU General Public License for more details.

;;;; You should have received a copy of the GNU General Public License
;;;; along with this program; if not, write to the Free Software
;;;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
;;;; See file COPYING in the psd distribution.
;;;; $Log: psd-sci.scm,v $
;;;; Revision 1.5  1993/10/06  13:04:28  pk
;;;; Removed reference to slib. Added qp.scm to files to be loaded.
;;;;
;;;; Revision 1.4  1993/09/29  08:43:28  pk
;;;; Removed reference to long and deep lists.
;;;;
;;;; Revision 1.3  1993/09/24  08:00:24  pk
;;;; Changed version number from 1.0 to 1.1.
;;;; Added loading of version.scm and announcing of version.
;;;; Added procedure list?.
;;;;
;;;; Revision 1.2  1993/09/23  06:49:30  pk
;;;; Moved definition of the Scheme variable psd-directory from the psd*.scm
;;;; files to psd.el, which sends it to the Scheme process. This way, the path
;;;; to psd needs to be specified only once.
;;;;
;;;; Revision 1.1  1993/07/30  10:43:00  pk
;;;; Initial revision
;;;;
;;;; 

;;;; 
;;;; Written by Pertti Kellomaki, pk@cs.tut.fi
;;;;
;;;; SLIB interface to load psd files.

;;;; This is the file that takes care of loading psd into the Scheme
;;;; interpreter. If you want to modify psd to work with a particular
;;;; implementation, say "foo", this is the way to do it:

;;;; 1) Make a copy of the file "psd.scm" under the name "psd-foo.scm",
;;;;    and modify it to load "primitives-foo.scm" instead of
;;;;    "primitives.scm". You can also do other things.
;;;;
;;;; 2) Make a copy of the file "primitives.scm" under the name
;;;;    "primitives-foo.scm", and modify the definitions in it to
;;;;    know about the additional primitives in your implementation
;;;;
;;;; 3) When you now set the Emacs variable scheme-program-name to
;;;;    "foo" and give the commands ``M-x run-scheme'' ``M-x psd-mode'',
;;;;    you have a psd system that knows about your additional
;;;;    primitives.

;;; this is not portable.
(define psd:control-z (integer->char 26))

;;; FORCE-OUTPUT flushes any pending output on optional arg output port
;;; use this definition if your system doesn't have such a procedure.
(define (force-output . arg) #t)

;;;
;;;  sci (28sep90jfb) does not have a string procedure, nor a list? procedure.
;;;  Later versions may have them, so you might want to check that.
;;; 

(define (string . chars)
  (list->string chars))

(define (list? x)
  (or (null? x) (pair? x)))


(load (string-append psd-directory "qp.scm"))
(load (string-append psd-directory "version.scm"))
(load (string-append psd-directory "instrum.scm"))
(load (string-append psd-directory "pexpr.scm"))
(load (string-append psd-directory "read.scm"))
(load (string-append psd-directory "runtime.scm"))
(load (string-append psd-directory "primitives.scm"))

;;;
;;; Say hello
;;;

(psd-announce-version)
