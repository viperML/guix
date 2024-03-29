;;; GNU Guix --- Functional package management for GNU
;;; Copyright © 2017 Leo Famulari <leo@famulari.name>
;;; Copyright © 2020 Danny Milosavljevic <dannym@scratchpost.org>
;;; Copyright © 2021 Arun Isaac <arunisaac@systemreboot.net>
;;; Copyright © 2021 Efraim Flashner <efraim@flashner.co.il>
;;; Copyright © 2022 Sharlatan Hellseher <sharlatanus@gmail.com>
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

(define-module (gnu packages golang-compression)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix build-system go)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (gnu packages))

;;; Commentary:
;;;
;;; Please: Try to add new module packages in alphabetic order.
;;;
;;; Code:

(define-public go-github-com-andybalholm-brotli
  (package
    (name "go-github-com-andybalholm-brotli")
    (version "1.0.4")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/andybalholm/brotli")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1zvmj7gbnkq9xwv1bvcxk9acxl06y902148qwbd2kqwgs52wy2c0"))))
    (build-system go-build-system)
    (arguments
     `(#:import-path "github.com/andybalholm/brotli"))
    (home-page "https://github.com/andybalholm/brotli")
    (synopsis "Pure Go Brotli encoder and decoder")
    (description
     "This package is a brotli compressor and decompressor implemented in Go.
It was translated from the reference implementation
(@url{https://github.com/google/brotli,https://github.com/google/brotli}) with
the @code{c2go} tool at
@url{https://github.com/andybalholm/c2go,https://github.com/andybalholm/c2go}.")
    (license license:expat)))

(define-public go-github-com-golang-snappy
  (package
    (name "go-github-com-golang-snappy")
    (version "0.0.4")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/golang/snappy")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "004cw699yz3pdpawhjhpa0y94c4w479nw1rf39zj6h6027kpwv2j"))
       (patches (search-patches "go-github-com-golang-snappy-32bit-test.patch"))))
    (build-system go-build-system)
    (arguments
     `(#:import-path "github.com/golang/snappy"))
    (home-page "https://github.com/golang/snappy")
    (synopsis "Snappy compression format in the Go programming language")
    (description "This package provides a Go implementation of the Snappy
compression format.")
    (license license:bsd-3)))

(define-public go-github-com-klauspost-compress
  (package
    (name "go-github-com-klauspost-compress")
    (version "1.13.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/klauspost/compress")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0ydnf9rizlhm8rilh14674qqx272sbwbkjx06xn9pqvy6mmn2r3r"))))
    (build-system go-build-system)
    (arguments
     `(#:import-path "github.com/klauspost/compress"
       #:phases
       (modify-phases %standard-phases
         (add-before 'reset-gzip-timestamps 'fix-permissions
           (lambda* (#:key outputs #:allow-other-keys)
             ;; Provide write permissions on gzip files so that
             ;; reset-gzip-timestamps has sufficient permissions.
             (for-each make-file-writable
                       (find-files (assoc-ref outputs "out") ".gz$")))))))
    (propagated-inputs
     (list go-github-com-golang-snappy))
    (home-page "https://github.com/klauspost/compress")
    (synopsis "Go compression library")
    (description "@code{compress} provides various compression algorithms.")
    (license license:bsd-3)))

(define-public go-github.com-ulikunitz-xz
  (package
    (name "go-github.com-ulikunitz-xz")
    (version "0.5.8")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/ulikunitz/xz.git")
             (commit (string-append "v" version))))
       (file-name (string-append name "-" version "-checkout"))
       (sha256
        (base32 "1xnsymi5fmmm734bi4c6z57p5cvnyxlpi29yxs4v21w5k763aypd"))))
    (build-system go-build-system)
    (arguments
     `(#:import-path "github.com/ulikunitz/xz"))
    (home-page "https://github.com/ulikunitz/xz")
    (synopsis "Read and write xz compressed streams in Go")
    (description "This package provides a library to read and write xz
compressed streams in Go.")
    (license license:bsd-3)))

;;;
;;; Avoid adding new packages to the end of this file. To reduce the chances
;;; of a merge conflict, place them above by existing packages with similar
;;; functionality or similar names.
;;;
