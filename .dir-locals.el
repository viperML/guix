;; Per-directory local variables for GNU Emacs 23 and later.

((nil
  . ((fill-column . 78)
     (tab-width   .  8)

     ;; For use with 'bug-reference-prog-mode'.
     (bug-reference-url-format . "http://bugs.gnu.org/%s")
     (bug-reference-bug-regexp
      . "<https?://\\(debbugs\\|bugs\\)\\.gnu\\.org/\\([0-9]+\\)>")))
 (c-mode          . ((c-file-style . "gnu")))
 (scheme-mode
  .
  ((indent-tabs-mode . nil)
   (eval . (put 'eval-when 'scheme-indent-function 1))
   (eval . (put 'test-assert 'scheme-indent-function 1))
   (eval . (put 'test-equal 'scheme-indent-function 1))
   (eval . (put 'test-eq 'scheme-indent-function 1))
   (eval . (put 'call-with-input-string 'scheme-indent-function 1))
   (eval . (put 'guard 'scheme-indent-function 1))
   (eval . (put 'lambda* 'scheme-indent-function 1))
   (eval . (put 'substitute* 'scheme-indent-function 1))
   (eval . (put 'with-directory-excursion 'scheme-indent-function 1))
   (eval . (put 'package 'scheme-indent-function 0))
   (eval . (put 'origin 'scheme-indent-function 0))
   (eval . (put 'build-system 'scheme-indent-function 0))
   (eval . (put 'bag 'scheme-indent-function 0))
   (eval . (put 'graft 'scheme-indent-function 0))
   (eval . (put 'operating-system 'scheme-indent-function 0))
   (eval . (put 'file-system 'scheme-indent-function 0))
   (eval . (put 'manifest-entry 'scheme-indent-function 0))
   (eval . (put 'manifest-pattern 'scheme-indent-function 0))
   (eval . (put 'substitute-keyword-arguments 'scheme-indent-function 1))
   (eval . (put 'with-store 'scheme-indent-function 1))
   (eval . (put 'with-error-handling 'scheme-indent-function 0))
   (eval . (put 'with-mutex 'scheme-indent-function 1))
   (eval . (put 'with-atomic-file-output 'scheme-indent-function 1))
   (eval . (put 'call-with-compressed-output-port 'scheme-indent-function 2))
   (eval . (put 'call-with-decompressed-port 'scheme-indent-function 2))
   (eval . (put 'signature-case 'scheme-indent-function 1))
   (eval . (put 'emacs-batch-eval 'scheme-indent-function 0))
   (eval . (put 'emacs-batch-edit-file 'scheme-indent-function 1))
   (eval . (put 'emacs-substitute-sexps 'scheme-indent-function 1))
   (eval . (put 'emacs-substitute-variables 'scheme-indent-function 1))
   (eval . (put 'with-derivation-narinfo 'scheme-indent-function 1))
   (eval . (put 'with-derivation-substitute 'scheme-indent-function 1))

   (eval . (put 'syntax-parameterize 'scheme-indent-function 1))
   (eval . (put 'with-monad 'scheme-indent-function 1))
   (eval . (put 'mbegin 'scheme-indent-function 1))
   (eval . (put 'mwhen 'scheme-indent-function 1))
   (eval . (put 'munless 'scheme-indent-function 1))
   (eval . (put 'mlet* 'scheme-indent-function 2))
   (eval . (put 'mlet 'scheme-indent-function 2))
   (eval . (put 'run-with-store 'scheme-indent-function 1))
   (eval . (put 'run-with-state 'scheme-indent-function 1))

   ;; Recognize '~', '+', and '$', as used for gexps, as quotation symbols.
   ;; This notably allows '(' in Paredit to not insert a space when the
   ;; preceding symbol is one of these.
   (eval . (modify-syntax-entry ?~ "'"))
   (eval . (modify-syntax-entry ?$ "'"))
   (eval . (modify-syntax-entry ?+ "'"))))
 (emacs-lisp-mode . ((indent-tabs-mode . nil)))
 (texinfo-mode    . ((indent-tabs-mode . nil)
                     (fill-column . 72))))
