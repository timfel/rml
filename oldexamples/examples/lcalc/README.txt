

It is assumed you unpacked lcalc.tgz into the directory "RML/examples/lcalc" and
that this directory is the current directory. If you want to run the calculus
from another directory, you need to edit the make-file.



-- How to compile and run --


* Type "make" at the command-line to compile.

* Then type "lcalc" to start the calculus.

* Then enter a term followed by a newline and ^D (Control-D). This will reduce
  the given term as far as possible and display the result. If the resulting
  term is a stuck term this will be pointed out. (A stuck term is a term that is
  irreducible without being a value.)

* If you want to see all intermediary reductions steps, start the calculus with
  any command-line argument.



-- Deviations from the course book regarding the syntax of the calculus --


* "#" is used as the lambda-character.

* Sequences of terms is allowed anywhere a term is allowed, although sometimes
  you need to put the sequence within parantheses. If the outermost term is a
  sequence, newlines not followed by horizontal white space is used
  as the seperator. In all other places ";" is used as the seperator. All terms
  but the last in a sequence is required to be a definition of the form "<name>
  = <term>".

* Newlines followed by horizontal white space is ignored like any other white
  space.

* Lambda expression writte with a dot followed by white space adheres to syntax
  disambiguation rules described in the course book. In other words, as many
  characters as possible will be considered to be part of the lambda body.
  Whithout the white space after the dot, as few characters as possible will be
  considered to be a part of the body. For example, "#x.x 0" is the same term
  as "(#x.x) 0", whereas "#x. x 0" is the same as "#x.(x 0)".

* "##" is used to enter closed lambda. Lambdas entered with "#" are open. The
  meaning "closed" and "open" you have to figure out for yourself (in exercise
  3.5).

* "//" begin line comments.

* '+' and many other characters are allowed in variables names. Edit "lexer.l"
  if you want make more characters allowed in varible names. Of course, not all
  characters can be allowed without causing troubles.






