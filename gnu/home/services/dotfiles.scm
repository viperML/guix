;;; GNU Guix --- Functional package management for GNU
;;; Copyright © 2024 Ludovic Courtès <ludo@gnu.org>
;;; Copyright © 2024 Giacomo Leidi <goodoldpaul@autistici.org>
;;;
;;; This file is part of GNU Guix.
;;;
;;; GNU Guix is free software; you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 3 of the License, or (at
;;; your option) any later version.
;;;
;;; GNU Guix is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with GNU Guix.  If not, see <http://www.gnu.org/licenses/>.

(define-module (gnu home services dotfiles)
  #:use-module (gnu home services)
  #:use-module (gnu services)
  #:autoload   (guix build utils) (find-files)
  #:use-module (guix gexp)
  #:use-module (guix records)
  #:use-module ((guix utils) #:select (current-source-directory))
  #:use-module (srfi srfi-1)
  #:use-module (ice-9 ftw)
  #:use-module (ice-9 regex)
  #:export (home-dotfiles-service-type
            home-dotfiles-configuration
            home-dotfiles-configuration?
            home-dotfiles-configuration-source-directory
            home-dotfiles-configuration-directories
            home-dotfiles-configuration-excluded))

(define %home-dotfiles-excluded
  '(".*~"
    ".*\\.swp"
    "\\.git"
    "\\.gitignore"))

(define-record-type* <home-dotfiles-configuration>
  home-dotfiles-configuration make-home-dotfiles-configuration
  home-dotfiles-configuration?
  (source-directory  home-dotfiles-configuration-source-directory
                     (default (current-source-directory))
                     (innate))
  (directories       home-dotfiles-configuration-directories       ;list of strings
                     (default '()))
  (excluded          home-dotfiles-configuration-excluded       ;list of strings
                     (default %home-dotfiles-excluded)))

(define (import-dotfiles directory files)
  "Return a list of objects compatible with @code{home-files-service-type}'s
value.  Each object is a pair where the first element is the relative path
of a file and the second is a gexp representing the file content.  Objects are
generated by recursively visiting DIRECTORY and mapping its contents to the
user's home directory, excluding files that match any of the patterns in EXCLUDED."
  (define (strip file)
    (string-drop file (+ 1 (string-length directory))))

  (define (format file)
    ;; Remove from FILE characters that cannot be used in the store.
    (string-append
     "home-dotfiles-"
     (string-map (lambda (chr)
                   (if (and (char-set-contains? char-set:ascii chr)
                            (char-set-contains? char-set:graphic chr)
                            (not (memv chr '(#\. #\/ #\space))))
                       chr
                       #\-))
                 file)))

  (map (lambda (file)
         (let ((stripped (strip file)))
           (list stripped
                 (local-file file (format stripped)
                             #:recursive? #t))))
       files))

(define (home-dotfiles-configuration->files config)
  "Return a list of objects compatible with @code{home-files-service-type}'s
value, generated following GNU Stow's algorithm for each of the
directories in CONFIG, excluding files that match any of the patterns configured."
  (define excluded
    (home-dotfiles-configuration-excluded config))
  (define exclusion-rx
    (make-regexp (string-append "^.*(" (string-join excluded "|") ")$")))

  (define (directory-contents directory)
    (find-files directory
                (lambda (file stat)
                  (not (regexp-exec exclusion-rx
                                    (basename file))))))

  (define (resolve directory)
    ;; Resolve DIRECTORY relative to the 'source-directory' field of CONFIG.
    (if (string-prefix? "/" directory)
        directory
        (in-vicinity (home-dotfiles-configuration-source-directory config)
                     directory)))

  (append-map (lambda (directory)
                (let* ((directory (resolve directory))
                       (contents  (directory-contents directory)))
                  (import-dotfiles directory contents)))
              (home-dotfiles-configuration-directories config)))

(define-public home-dotfiles-service-type
  (service-type (name 'home-dotfiles)
                (extensions
                 (list (service-extension home-files-service-type
                                          home-dotfiles-configuration->files)))
                (default-value (home-dotfiles-configuration))
                (description "Files that will be put in the user's home directory
following GNU Stow's algorithm, and further processed during activation.")))