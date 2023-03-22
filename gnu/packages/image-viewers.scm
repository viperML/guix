;;; GNU Guix --- Functional package management for GNU
;;; Copyright © 2013, 2017-2022 Ludovic Courtès <ludo@gnu.org>
;;; Copyright © 2014 Ian Denhardt <ian@zenhack.net>
;;; Copyright © 2015, 2016 Alex Kost <alezost@gmail.com>
;;; Copyright © 2016, 2017, 2018, 2019, 2020, 2021 Efraim Flashner <efraim@flashner.co.il>
;;; Copyright © 2017 Alex Griffin <a@ajgrf.com>
;;; Copyright © 2017 Nikita <nikita@n0.is>
;;; Copyright © 2017 Mathieu Othacehe <m.othacehe@gmail.com>
;;; Copyright © 2017 nee <nee-git@hidamari.blue>
;;; Copyright © 2018–2021 Tobias Geerinckx-Rice <me@tobias.gr>
;;; Copyright © 2018, 2019 Ricardo Wurmus <rekado@elephly.net>
;;; Copyright © 2019, 2022 Nicolas Goaziou <mail@nicolasgoaziou.fr>
;;; Copyright © 2019, 2020, 2022 Guy Fleury Iteriteka <gfleury@disroot.org>
;;; Copyright © 2019 Pierre Langlois <pierre.langlois@gmx.com>
;;; Copyright © 2020 Peng Mei Yu <pengmeiyu@riseup.net>
;;; Copyright © 2020 R Veera Kumar <vkor@vkten.in>
;;; Copyright © 2020 Pierre Neidhardt <mail@ambrevar.xyz>
;;; Copyright © 2021 Rovanion Luckey <rovanion.luckey@gmail.com>
;;; Copyright © 2021 Xinglu Chen <public@yoctocell.xyz>
;;; Copyright © 2021 Stefan Reichör <stefan@xsteve.at>
;;; Copyright © 2021 Raghav Gururajan <rg@raghavgururajan.name>
;;; Copyright © 2021 jgart <jgart@dismail.de>
;;; Copyright © 2021 Guillaume Le Vaillant <glv@posteo.net>
;;; Copyright © 2021 Zheng Junjie <873216071@qq.com>
;;; Copyright © 2021 dissent <disseminatedissent@protonmail.com>
;;; Copyright © 2022 Michael Rohleder <mike@rohleder.de>
;;; Copyright © 2022, 2023 Maxim Cournoyer <maxim.cournoyer@gmail.com>
;;; Copyright © 2022 Tomasz Jeneralczyk <tj@schwi.pl>
;;; Copyright © 2022 Cairn <cairn@pm.me>
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

(define-module (gnu packages image-viewers)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system go)
  #:use-module (guix build-system meson)
  #:use-module (guix build-system python)
  #:use-module (guix build-system qt)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages algebra)
  #:use-module (gnu packages animation)
  #:use-module (gnu packages backup)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages boost)
  #:use-module (gnu packages check)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages documentation)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages gawk)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages ghostscript)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages golang)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages graphics)
  #:use-module (gnu packages image)
  #:use-module (gnu packages image-processing)
  #:use-module (gnu packages imagemagick)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages pdf)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages perl-check)
  #:use-module (gnu packages photo)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-check)
  #:use-module (gnu packages python-compression)
  #:use-module (gnu packages python-crypto)
  #:use-module (gnu packages python-web)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages qt)
  #:use-module (gnu packages suckless)
  #:use-module (gnu packages terminals)
  #:use-module (gnu packages upnp)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages video)
  #:use-module (gnu packages vim)
  #:use-module (gnu packages web)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages))

(define-public ytfzf
  (package
    (name "ytfzf")
    (version "2.5.2")
    (home-page "https://github.com/pystardust/ytfzf")
    (source
     (origin
       (method git-fetch)
       (uri
        (git-reference
         (url home-page)
         (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "138rqjjyh6ar951v0v5sl1v000ja8zznn141qqw8ymx5h2z44r6w"))))
    (build-system gnu-build-system)
    (arguments
     (list
      #:tests? #f                       ;no test suite
      #:make-flags
      #~(list (string-append "PREFIX=" #$output))
      #:phases
      #~(modify-phases %standard-phases
          (delete 'configure)
          (add-after 'install 'install-addons
            (lambda _
              (invoke "make" "addons"
                      (string-append "PREFIX=" #$output))))
          (add-after 'install 'wrap-program
            (lambda* (#:key inputs #:allow-other-keys)
              (wrap-program (string-append #$output "/bin/ytfzf")
                `("PATH" ":" prefix
                  ,(map (lambda (input)
                          (string-append (assoc-ref inputs input) "/bin"))
                        '("bash" "catimg" "chafa" "coreutils" "curl"
                          "dmenu" "fzf" "gawk" "grep" "jp2a" "jq"
                          "libnotify" "mpv" "ncurses" "python-ueberzug"
                          "sed" "util-linux" "youtube-dl")))
                `("YTFZF_SYSTEM_ADDON_DIR" ":" =
                  ,(list (string-append #$output "/share/ytfzf/addons")))))))))
    (inputs
     (list bash
           catimg
           chafa
           coreutils
           curl
           dmenu
           fzf
           gawk
           grep
           jp2a
           jq
           libnotify
           mpv
           ncurses
           perl                         ;for convert-ascii-escape.pl
           python-ueberzug
           sed
           util-linux
           youtube-dl))
    (synopsis "Watch PeerTube or YouTube videos from the terminal")
    (description "@code{ytfzf} is a POSIX script that helps you find PeerTube or
YouTube videos without requiring API and opens/downloads them using mpv/ytdl.")
    (license license:gpl3+)))

(define-public feh
  (package
    (name "feh")
    (version "3.9")
    (home-page "https://feh.finalrewind.org/")
    (source (origin
              (method url-fetch)
              (uri (string-append home-page
                                  name "-" version ".tar.bz2"))
              (sha256
               (base32
                "185wwqd60r2rk6lzcvd6sl58589qfqrfnf7lqd6friyj84n9cjc6"))))
    (build-system gnu-build-system)
    (arguments
     (list #:phases
           #~(modify-phases %standard-phases
               (delete 'configure))     ; no configure script
           #:test-target "test"
           #:make-flags
           #~(list (string-append "CC=" #$(cc-for-target))
                   (string-append "PREFIX=" #$output)
                   "exif=1"
                   "inotify=1"
                   "magic=1")))
    (native-inputs
     (list perl perl-test-command))
    (inputs (list curl
                  imlib2
                  libexif
                  libpng
                  libx11
                  libxinerama
                  libxt))
    (native-search-paths
     ;; Feh allows overriding the libcurl builtin CA path (unset in Guix)
     ;; with the same variable as the `curl` command line HTTP tool.
     (list (search-path-specification
            (variable "CURL_CA_BUNDLE")
            (file-type 'regular)
            (separator #f)                             ;single entry
            (files '("etc/ssl/certs/ca-certificates.crt")))))
    (synopsis "Fast and light imlib2-based image viewer")
    (description
      "feh is an X11 image viewer aimed mostly at console users.
Unlike most other viewers, it does not have a fancy GUI, but simply
displays images.  It can also be used to set the desktop wallpaper.
It is controlled via commandline arguments and configurable key/mouse
actions.")

    ;; The license is really the Expat license, with additional wording in the
    ;; 2nd paragraph: "acknowledgment shall be given in the documentation and
    ;; software packages that this Software was used."
    (license (license:x11-style
              "file://COPYING"
              "See 'COPYING' in the distribution."))))

(define-public geeqie
  (package
    (name "geeqie")
    (version "2.0.1")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/BestImageViewer/geeqie")
                    (commit (string-append "v" version))))
              (sha256
               (base32
                "199s0f3khnycr5vhk2ww3xnnasz7dzwxdl89pxjadq6rpgprfqyh"))
              (file-name (git-file-name name version))))
    (build-system meson-build-system)
    (inputs
     (list exiv2
           gtk+
           lcms
           libchamplain
           libpng))
    (native-inputs
     (list `(,glib "bin") ; glib-gettextize
           intltool
           pkg-config
           xxd))
    (home-page "https://www.geeqie.org/")
    (synopsis "Lightweight GTK+ based image viewer")
    (description
     "Geeqie is a lightweight GTK+ based image viewer for Unix like operating
systems.  It features: EXIF, IPTC and XMP metadata browsing and editing
interoperability; easy integration with other software; geeqie works on files
and directories, there is no need to import images; fast preview for many raw
image formats; tools for image comparison, sorting and managing photo
collection.  Geeqie was initially based on GQview.")
    (license license:gpl2+)))

(define-public gpicview
  (package
    (name "gpicview")
    (version "0.2.5")
    (source (origin
              (method url-fetch)
              (uri (string-append "mirror://sourceforge/lxde/"
                                  "GPicView%20%28image%20Viewer%29/0.2.x/"
                                  name "-" version ".tar.xz"))
              (sha256
               (base32
                "0hi9v0rdx47nys0wvm9xasdrafa34r5kq6crb074a0ipwmc60iiq"))))
    (build-system gnu-build-system)
    (arguments (list #:configure-flags #~(list "--enable-gtk3")))
    (inputs (list gtk+ libjpeg-turbo))
    (native-inputs (list intltool pkg-config))
    (synopsis "Simple and fast image viewer for X")
    (description "gpicview is a lightweight GTK+ 2.x based image viewer.
It is the default image viewer on LXDE desktop environment.")
    (home-page "https://lxde.sourceforge.net/gpicview/")
    (license license:gpl2+)))

(define-public sxiv
  (package
    (name "sxiv")
    (version "26")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/muennich/sxiv")
                    (commit (string-append "v" version))))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "0xaawlfdy7b277m38mgg4423kd7p1ffn0dq4hciqs6ivbb3q9c4f"))))
    (build-system gnu-build-system)
    (arguments
     `(#:tests? #f                      ; no check target
       #:make-flags
       (list (string-append "PREFIX=" %output)
             (string-append "CC=" ,(cc-for-target))
             ;; Xft.h #includes <ft2build.h> without ‘freetype2/’.  The Makefile
             ;; works around this by hard-coding /usr/include & $PREFIX.
             (string-append "CPPFLAGS=-I"
                            (assoc-ref %build-inputs "freetype")
                            "/include/freetype2")
             "V=1")
       #:phases
       (modify-phases %standard-phases
         (delete 'configure)            ; no configure script
         (add-after 'install 'install-desktop-file
           (lambda* (#:key outputs #:allow-other-keys)
             (install-file "sxiv.desktop"
                           (string-append (assoc-ref outputs "out")
                                          "/share/applications"))
             #t))
         (add-after 'install 'install-icons
           (lambda* (#:key make-flags #:allow-other-keys)
             (apply invoke "make" "-C" "icon" "install" make-flags))))))
    (inputs
     (list freetype
           giflib
           imlib2
           libexif
           libx11
           libxft))
    (home-page "https://github.com/muennich/sxiv")
    (synopsis "Simple X Image Viewer")
    (description
     "sxiv is an alternative to feh and qiv.  Its primary goal is to
provide the most basic features required for fast image viewing.  It has
vi key bindings and works nicely with tiling window managers.  Its code
base should be kept small and clean to make it easy for you to dig into
it and customize it for your needs.")
    (license license:gpl2+)))

(define-public nsxiv
  (package
    (name "nsxiv")
    (version "27.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/nsxiv/nsxiv")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1na7f0hpc9g04nm7991gzaqr5gkj08n2azx833hgxcm2w1pnn1bk"))))
    (build-system gnu-build-system)
    (arguments
     `(#:tests? #f                      ;no check target
       #:make-flags
       (list (string-append "PREFIX=" %output)
             (string-append "CC=" ,(cc-for-target)))
       #:phases
       (modify-phases %standard-phases
         (delete 'configure)            ;no configure script
         (add-after 'unpack 'fix-paths
           (lambda* (#:key inputs #:allow-other-keys)
             ;; Xft.h #includes <ft2build.h> without ‘freetype2/’.  The
             ;; Makefile works around this by hard-coding /usr/include &
             ;; $PREFIX.
             (let ((freetype (string-append (assoc-ref inputs "freetype")
                                            "/include/freetype2")))
               (substitute* "Makefile"
                 (("-I/usr/include/freetype2 -I\\$\\(PREFIX\\)/include/freetype2")
                  (string-append "-I" freetype))))))
         (add-after 'install 'install-desktop-file
           (lambda* (#:key outputs #:allow-other-keys)
             (install-file "nsxiv.desktop"
                           (string-append (assoc-ref outputs "out")
                                          "/share/applications"))))
         (add-after 'install 'install-icons
           (lambda* (#:key make-flags #:allow-other-keys)
             (apply invoke "make" "-C" "icon" "install" make-flags))))))
    (inputs
     (list freetype
           giflib
           imlib2
           libexif
           libx11
           libxft))
    (home-page "https://github.com/nsxiv/nsxiv")
    (synopsis "Neo Simple X Image Viewer")
    (description
     "nsxiv is a fork of sxiv.  Its primary goal is to provide the most basic
features required for fast image viewing.  It has vi key bindings and works
nicely with tiling window managers.  Its code base should be kept small and
clean to make it easy for you to dig into it and customize it for your
needs.")
    (license license:gpl2+)))

(define-public viewnior
  (package
    (name "viewnior")
    (version "1.8")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/hellosiyan/Viewnior")
             (commit (string-append name "-" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "14qvx1wajncd5ab0207274cwk32f4ipfnlaci6phmah0cwra2did"))))
    (build-system meson-build-system)
    (arguments
     '(#:phases (modify-phases %standard-phases
                  (add-after 'unpack 'patch-source
                    (lambda _
                      ;; Don't create 'icon-theme.cache'
                      (substitute* "meson.build"
                        (("meson.add_install_script*") "")))))
       #:tests? #f))                    ;no tests
    (native-inputs
     (list gettext-minimal
           `(,glib "bin")               ;glib-genmarshal
           pkg-config
           shared-mime-info))
    (inputs
     (list exiv2
           gdk-pixbuf
           gtk+-2))
    (home-page "https://siyanpanayotov.com/project/viewnior")
    (synopsis "Simple, fast and elegant image viewer")
    (description "Viewnior is an image viewer program.  Created to be simple,
fast and elegant.  Its minimalistic interface provides more screenspace for
your images.  Among its features are:
@enumerate
@item Fullscreen & Slideshow
@item Rotate, flip, crop, save, delete images
@item Animation support
@item Browse only selected images
@item Navigation window
@item Set image as wallpaper (Gnome 2, Gnome 3, XFCE, LXDE, FluxBox, Nitrogen)
@item Simple interface
@item EXIF and IPTC metadata
@item Configurable mouse actions
@end enumerate\n")
    (license license:gpl3+)))

(define-public catimg
  (package
    (name "catimg")
    (version "2.7.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/posva/catimg")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0a2dswbv4xddb2l2d55hc43lzvjwrjs5z9am7v6i0p0mi2fmc89s"))))
    (build-system cmake-build-system)
    (arguments
     `(#:tests? #f                      ; no tests
       #:phases
       (modify-phases %standard-phases
         (add-after 'unpack 'patch-convert
           (lambda _
             (substitute* "catimg"
               ;; By replacing "convert", we also replace the "convert"
               ;; in the message 'The version of convert is too old, don't
               ;; expect good results :('.  This should not happen, but in
               ;; practice this error message should not affect us.
               (("convert") (which "convert")))
             #t))
         (add-after 'install 'install-script
           (lambda* (#:key outputs #:allow-other-keys)
             ;; The bash script lacks an file extension.  We have to rename
             ;; it so that the C program and the bash script can be happy
             ;; side by side.
             (copy-file "../source/catimg"
                        (string-append (assoc-ref outputs "out")
                                       "/bin/catimg.sh"))
             #t)))))
    (inputs
     (list imagemagick)) ; for the bash script version
    (home-page "https://github.com/posva/catimg")
    (synopsis "Render images in the terminal")
    (description
     "Catimg is a little program that prints images in the terminal.
It supports JPEG, PNG and GIF formats.")
    (license license:expat)))

(define-public pixterm
  (package
    (name "pixterm")
    (version "1.3.1")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/eliukblau/pixterm")
                    (commit (string-append "v" version))))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "0fm6c0mjz6zillqjirnjjf7mkrax1gyfcv6777i07ms3bnv0pcii"))))
    (build-system go-build-system)
    (arguments
     '(#:import-path "github.com/eliukblau/pixterm/cmd/pixterm"
       #:unpack-path "github.com/eliukblau/pixterm"))
    (inputs (list go-github-com-disintegration-imaging
                  go-github-com-lucasb-eyer-go-colorful
                  go-golang-org-x-crypto
                  go-golang-org-x-image))
    (home-page "https://github.com/eliukblau/pixterm")
    (synopsis "Draw images in your ANSI terminal with true color")
    (description "PIXterm shows images directly in your terminal, recreating
the pixels through a combination of ANSI character background color and the
unicode lower half block element.  It supports JPEG, PNG, GIF, BMP, TIFF
and WebP.")
    (license license:mpl2.0)))

(define-public luminance-hdr
  (package
    (name "luminance-hdr")
    (version "2.6.0")
    (source (origin
              (method url-fetch)
              (uri (string-append
                    "mirror://sourceforge/qtpfsgui/luminance/"
                    version "/luminance-hdr-" version ".tar.bz2"))
              (sha256
               (base32
                "188q0l63nfasqfvwbq4mwx2vh7wsfi2bq9n5nksddspl1qz01lnp"))))
    (build-system cmake-build-system)
    (native-inputs
     (list pkg-config qttools-5))
    (inputs
     (list qtbase-5
           qtdeclarative-5
           qtsvg-5
           boost
           eigen
           ;; gtest
           libraw
           zlib
           exiv2
           libpng
           libjpeg-turbo
           lcms
           openexr-2
           qtwebengine-5
           qtdeclarative-5
           qtwebchannel-5
           fftwf
           gsl
           libtiff))
    (arguments
     '(#:tests? #f  ;XXX: some tests fail to compile
       #:phases
       (modify-phases %standard-phases
         (add-after 'set-paths 'add-ilmbase-include-path
           (lambda* (#:key inputs #:allow-other-keys)
             ;; 'OpenEXR.pc' has a -I for IlmBase but 'FindOpenEXR.cmake' does
             ;; not use 'OpenEXR.pc'.  Thus, we need to add
             ;; "$ilmbase/include/OpenEXR/" to the CPLUS_INCLUDE_PATH.
             (setenv "CPLUS_INCLUDE_PATH"
                     (string-append
                      (dirname
                       (search-input-file inputs "include/OpenEXR/ImathInt64.h"))
                      ":" (or (getenv "CPLUS_INCLUDE_PATH") ""))))))))
    (home-page "https://qtpfsgui.sourceforge.net")
    (synopsis "High dynamic range (HDR) imaging application")
    (description
     "Luminance HDR (formerly QtPFSGui) is a graphical user interface
application that aims to provide a workflow for high dynamic range (HDR)
imaging.  It supports several HDR and LDR image formats, and it can:

@itemize
@item Create an HDR file from a set of images (formats: JPEG, TIFF 8bit and
16bit, RAW) of the same scene taken at different exposure setting;
@item Save load HDR images;
@item Rotate, resize and crop HDR images;
@item Tone-map HDR images;
@item Copy EXIF data between sets of images.
@end itemize\n")
    (license license:gpl2+)))

;; CBR and RAR are currently unsupported, due to non-free dependencies.
(define-public mcomix
  (package
    (name "mcomix")
    (version "2.0.2")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "mirror://sourceforge/mcomix/MComix-" version "/"
                           "mcomix-" version ".tar.gz"))
       (sha256
        (base32
         "0n0akk3njsm0paqxfbxqycwhwy6smjg0rhlcz5r7r82n7rqx0f7g"))))
    (build-system python-build-system)
    (inputs
     (list p7zip python python-pillow python-pygobject python-pycairo gtk+))
    (arguments
     (list
      #:imported-modules `(,@%python-build-system-modules
                           (guix build glib-or-gtk-build-system))
      #:modules '((guix build python-build-system)
                  ((guix build glib-or-gtk-build-system) #:prefix glib-or-gtk:)
                  (guix build utils))
      #:phases
      #~(modify-phases %standard-phases
          (add-after 'unpack 'patch-source
            (lambda* (#:key inputs #:allow-other-keys)
              (substitute* "mcomix/archive/sevenzip_external.py"
                ;; Ensure that 7z is found by hardcoding its absolute path.
                (("_7z_executable = -1")
                 (format #f "_7z_executable = ~s"
                         (search-input-file inputs "/bin/7z"))))
              (substitute* "mcomix/image_tools.py"
                (("assert name not in supported_formats_gdk")
                 "if name in supported_formats_gdk: continue"))))
         (add-after 'install 'install-data
           (lambda* (#:key outputs #:allow-other-keys)
             (with-directory-excursion "mcomix"
               (for-each
                (lambda (subdir)
                  (copy-recursively
                   subdir
                   (string-append
                    (assoc-ref outputs "out")
                    "/lib/python"
                    #$(version-major+minor
                       (package-version (this-package-input "python")))
                    "/site-packages/mcomix/" subdir)))
                '("images" "messages")))))
         (add-after 'glib-or-gtk-compile-schemas 'glib-or-gtk-wrap
           (assoc-ref glib-or-gtk:%standard-phases 'glib-or-gtk-wrap))
         (add-after 'wrap 'gi-wrap
           (lambda* (#:key outputs #:allow-other-keys)
             (let ((bin (string-append (assoc-ref outputs "out") "/bin")))
               (for-each
                (lambda (prog)
                  (wrap-program prog
                    `("GI_TYPELIB_PATH" = (,(getenv "GI_TYPELIB_PATH")))))
                (list (string-append bin "/mcomix")))))))))
    (home-page "https://sourceforge.net/p/mcomix/wiki/Home/")
    (synopsis "Image viewer for comics")
    (description "MComix is a customizable image viewer that specializes as
a comic and manga reader.  It supports a variety of container formats
including CBZ, CB7, CBT, LHA.

For PDF support, install the @emph{mupdf} package.")
    (license license:gpl2+)))

(define-public qview
  (package
    (name "qview")
    (version "5.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/jurplel/qView")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1ck4mvhzc4m72n010n43d8ipjczzk6ya637rgfyi7bzb4gv0f3am"))))
    (build-system qt-build-system)
    (arguments
     (list
      #:phases
      #~(modify-phases %standard-phases
          (replace 'configure
            (lambda* (#:key outputs #:allow-other-keys)
              (invoke "qmake" (string-append "PREFIX=" #$output))))
          ;; Don't phone home or show "Checking for updates..." in the About
          ;; menu.
          (add-before 'build 'disable-auto-update
            (lambda _
              (substitute* "src/qvaboutdialog.cpp"
                (("qvApp->checkUpdates\\(\\);") "")
                (("updateText\\(\\);") ""))))
          (replace 'check
            (lambda* (#:key tests? #:allow-other-keys)
              (when tests?
                (with-directory-excursion "tests"
                  (invoke "qmake" "tests.pro")
                  (invoke "make" "tests"))))))))
    (native-inputs
     (list qttools-5))
    (inputs
     (list qtbase-5 qtimageformats qtsvg-5))
    (home-page "https://interversehq.com/qview/")
    (synopsis "Convenient and minimal image viewer")
    (description "qView is a Qt image viewer designed with visually
minimalism and usability in mind.  Its features include animated GIF
controls, file history, rotation/mirroring, and multithreaded
preloading.")
    (license license:gpl3+)))

(define-public chafa
  (package
    (name "chafa")
    (version "1.12.4")
    (source (origin
              (method url-fetch)
              (uri (string-append "https://hpjansson.org/chafa/releases/chafa-"
                                  version ".tar.xz"))
              (sha256
               (base32
                "0gsp39xnra331lk0db5pfqpdmqfhf7ii3a7yywj33sknf0dbsx4p"))))
    (build-system gnu-build-system)
    (native-inputs
     (list pkg-config))
    (inputs
     (list freetype libjpeg-turbo glib imagemagick))
    (synopsis "Convert images to ANSI/Unicode characters")
    (description
     "Chafa is a command-line utility that converts all kinds of images,
including animated GIFs, into ANSI/Unicode character output that can be
displayed in a terminal.")
    (home-page "https://hpjansson.org/chafa/")
    (license license:lgpl3+)))

(define-public imv
  (package
    (name "imv")
    (version "4.4.0")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://git.sr.ht/~exec64/imv")
                    (commit (string-append "v" version))))
              (sha256
               (base32
                "1zlds43z17jrnsrfz3rf3sb3pa5gkmxaibq87509ikc7p1p09c9c"))
              (file-name (git-file-name name version))))
    (build-system meson-build-system)
    (arguments
     (list #:phases
           #~(modify-phases %standard-phases
               (add-after 'install 'record-absolute-file-names
                 (lambda _
                   ;; 'imv' is a script that execs 'imv-x11' or 'imv-wayland'.
                   ;; 'imv-dir' execs 'imv'. Record their absolute file names.
                   (let ((bin (string-append #$output "/bin")))
                     (substitute* (string-append bin "/imv")
                       (("imv-") (string-append bin "/imv-")))
                     (substitute* (string-append bin "/imv-dir")
                       (("imv") (string-append bin "/imv")))))))))
    (native-inputs
     (list asciidoc
           pkg-config))
    (inputs
     (list freeimage
           glu
           libheif
           libjpeg-turbo
           libinih
           libnsgif
           librsvg
           libtiff
           libxkbcommon
           pango
           wayland))
    (synopsis "Image viewer for tiling window managers")
    (description "@code{imv} is a command line image viewer intended for use
with tiling window managers.  Features include:

@itemize
@item Native Wayland and X11 support.
@item Support for dozens of image formats including:
@itemize
@item PNG
@item JPEG
@item Animated GIFs
@item SVG
@item TIFF
@item Various RAW formats
@item Photoshop PSD files
@end itemize
@item Configurable key bindings and behavior.
@item Highly scriptable with IPC via imv-msg.
@end itemize\n")
    (home-page "https://git.sr.ht/~exec64/imv/")
    (license license:expat)))

(define-public qiv
  (package
    (name "qiv")
    (version "2.3.2")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "http://spiegl.de/qiv/download/qiv-"
                           version ".tgz"))
       (sha256
        (base32 "1mc0f2nnas4q0d7zc9r6g4z93i32xlx0p9hl4fn5zkyml24a1q28"))
       (modules '((guix build utils)))
       (snippet
        '(begin
           ;; Fix a typo.  This can probably be removed on the next update.
           (substitute* "Makefile"
             (("\\$\\(PREFIX\\)/man")
              "$(PREFIX)/share/man"))))))
    (build-system gnu-build-system)
    (native-inputs
     (list pkg-config
           ;; That is required for testing.
           xorg-server-for-tests))
    (inputs
     `(("imlib2" ,imlib2)
       ("glib" ,glib)
       ("gtk+" ,gtk+-2)
       ("lcms" ,lcms)
       ("libjpeg" ,libjpeg-turbo)
       ("libtiff" ,libtiff)
       ("libexif" ,libexif)
       ("libx11" ,libx11)
       ("libxext" ,libxext)))
    (arguments
     `(#:phases
       (modify-phases %standard-phases
         (delete 'configure)            ; no configure script
         (add-before 'install 'patch-file-start-xserver
           (lambda* (#:key inputs #:allow-other-keys)
             ;; patch the file so that qiv runs and exits by itself
             (substitute* "Makefile"
               (("./qiv -f ./intro.jpg") "./qiv -f -C -s ./intro.jpg")
               ;; Fail the build when test fails.
               (("echo \"-- Test Failed --\"")
                "(echo \"-- Test Failed --\" ; false)"))
             ;; There must be a running X server and make install doesn't start one.
             ;; Therefore we must do it.
             (system "Xvfb :1 &")
             (setenv "DISPLAY" ":1"))))
       #:tests? #f                      ; there is no check target
       #:make-flags
       (list
        (string-append "PREFIX=" (assoc-ref %outputs "out")))))
    (home-page "https://spiegl.de/qiv/")
    (synopsis "Graphical image viewer for X")
    (description
     "Quick Image Viewer is a small and fast GDK/Imlib2 image viewer.
Features include zoom, maxpect, scale down, fullscreen, slideshow, delete,
brightness/contrast/gamma correction, pan with keyboard and mouse, flip,
rotate left/right, jump/forward/backward images, filename filter and use it
to set X desktop background.")
    (license license:gpl2)))

(define-public pqiv
  (package
    (name "pqiv")
    (version "2.12")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/phillipberndt/pqiv")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "18nvrqmlifh4m8nfs0d19sb9d1l3a95xc89qxqdr881jcxdsgflw"))))
    (build-system gnu-build-system)
    (native-inputs
     (list pkg-config))
    (inputs
     (list ffmpeg
           gtk+
           imagemagick
           libarchive
           libspectre
           libwebp
           poppler))
    (arguments
     `(#:tests? #f                      ;no tests
       #:phases
       (modify-phases %standard-phases
         (delete 'configure))           ;no configure script
       #:make-flags
       (list
        (string-append "PREFIX=" (assoc-ref %outputs "out"))
        (string-append "CC=" ,(cc-for-target))
        (string-append "PKG_CONFIG=" ,(pkg-config-for-target)))))
    (home-page "https://www.pberndt.com/Programme/Linux/pqiv")
    (synopsis "Powerful image viewer with minimal UI")
    (description
     "pqiv is a GTK-3 based command-line image viewer with a minimal UI.
It is highly customizable, can be fully controlled from scripts, and has
support for various file formats including PDF, Postscript, video files and
archives.")
    (license license:gpl3+)))

(define-public nomacs
  (package
    (name "nomacs")
    (version "3.16.224")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/nomacs/nomacs")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "05d4hqg0gl3g9s2xf1hr7mc7g4cqarcap4nzxxa51fsphw2b8x16"))))
    (build-system cmake-build-system)
    (arguments
     `(#:build-type "Release" ; fails to build with debug info
       #:configure-flags (list "-DENABLE_TRANSLATIONS=true"
                               "-DUSE_SYSTEM_QUAZIP=true"
                               "-DENABLE_OPENCV=true")
       #:tests? #f ; no rule for target 'test'
       #:phases
       (modify-phases %standard-phases
         (add-after 'unpack 'copy-plugins
           (lambda* (#:key inputs #:allow-other-keys)
             (copy-recursively (assoc-ref inputs "plugins")
                               "ImageLounge/plugins")))
         (add-after 'copy-plugins 'cd-to-source-dir
           (lambda _ (chdir "ImageLounge") #t)))))
    (inputs
     `(("plugins"
        ,(origin
           (method git-fetch)
           (uri (git-reference
                 (url "https://github.com/nomacs/nomacs-plugins")
                 (commit "3.16")))
           (sha256
            (base32
             "1cpdwhfvaxm970nwdc1hc13848a85pqqi176m9xpa3krla9qskml"))))
       ("exiv2" ,exiv2)
       ("libraw" ,libraw)
       ("libtiff" ,libtiff)
       ("opencv" ,opencv)
       ("python" ,python-wrapper)
       ("quazip" ,quazip-0)
       ("qtbase" ,qtbase-5)
       ("qtsvg-5" ,qtsvg-5)))
    (native-inputs
     `(("pkg-config" ,pkg-config)
       ("qtlinguist" ,qttools-5)))
    (synopsis "Image viewer supporting all common formats")
    (description "Nomacs is a simple to use image lounge featuring
semi-transparent widgets that display additional information such as metadata,
thumbnails and histograms.  It is able to browse images compressed archives
and add notes to images.

Nomacs includes image manipulation methods for adjusting brightness, contrast,
saturation, hue, gamma, and exposure.  It has a pseudo color function which
allows creating false color images.  A unique feature of Nomacs is the
synchronization of multiple instances.")
    (home-page "https://nomacs.org/")
    (license license:gpl3+)))

(define-public xzgv
  (package
    (name "xzgv")
    (version "0.9.2")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "mirror://sourceforge/xzgv/"
                           version "/xzgv-" version ".tar.gz"))
       (sha256
        (base32 "17l1xr9v07ggwga3vn0z1i4lnwjrr20rr8z1kjbw71aaijxl18i5"))))
    (build-system gnu-build-system)
    (arguments
     `(#:phases
       (modify-phases %standard-phases
         (add-after 'unpack 'override-target-directory
           (lambda* (#:key outputs #:allow-other-keys)
             (substitute* "config.mk"
               (("/usr/local") (assoc-ref outputs "out")))))
         (delete 'configure)            ; no configure script
         (replace 'install
           (lambda* (#:key outputs #:allow-other-keys)
             (let* ((out (assoc-ref outputs "out"))
                    (bin (string-append out "/bin")))
               (install-file "src/xzgv" bin))))) ; just install the executable
       #:tests? #f))                             ; no rule for target 'test'
    (native-inputs
     (list pkg-config))
    (inputs
     (list gtk+-2 libexif))
    (home-page "https://sourceforge.net/projects/xzgv/")
    (synopsis "Picture viewer for X with a thumbnail-based selector")
    (description
     "xzgv is a fast image viewer that provides extensive keyboard support.")
    (license license:gpl2+)))

(define-public hydrus-network
  (package
    (name "hydrus-network")
    (version "495")                       ;upstream has a weekly release cycle
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/hydrusnetwork/hydrus")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "03zhrcmjzbk37sl9nwjahfmr8aflss84c4xhg5ci5b8jvbbqmr1j"))
       (modules '((guix build utils)))
       (snippet
        ;; Remove pre-built binaries from bin/.
        #~(for-each delete-file (find-files "bin" "^swfrender")))))
    (build-system python-build-system)
    (arguments
     (list
      #:phases
      #~(let ((static-dir "/share/hydrus/static"))
          (modify-phases %standard-phases
            ;; Hydrus is a python program but does not uses setup.py or any
            ;; other build system to build itself - it's delivered ready to
            ;; run from the source.
            (replace 'check
              (lambda _
                (setenv "DISPLAY" ":0")
                (setenv "XDG_CACHE_HOME" (getcwd))
                (setenv "HOME" (getcwd))
                (invoke "xvfb-run" "python" "test.py")))
            ;; XXX: program help files are not built.  Updating
            ;; python-pymdown-extensions to its latest version might be the
            ;; solution, but this would require also packaging its new build
            ;; system that is not present in guix yet.
            (delete 'build)
            (add-before 'install 'patch-variables
              (lambda* (#:key outputs inputs #:allow-other-keys)
                (let ((ffmpeg    (search-input-file inputs "/bin/ffmpeg"))
                      (swfrender (search-input-file inputs "/bin/swfrender"))
                      (upnpc     (search-input-file inputs "/bin/upnpc"))
                      (out       (assoc-ref outputs "out")))
                  (with-directory-excursion "hydrus"
                    ;; Without this the program would incorrectly assume
                    ;; that it uses user's ffmpeg binary when it isn't.
                    (substitute* "client/ClientController.py"
                      (("if (HydrusVideoHandling\\.FFMPEG_PATH).*" _ var)
                       (string-append "if " var " == \"" ffmpeg "\":\n")))
                    (with-directory-excursion "core"
                      (substitute* "HydrusConstants.py"
                        (("STATIC_DIR = .*")
                         (string-append "STATIC_DIR = \"" out static-dir "\"\n")))
                      (substitute* "HydrusFlashHandling.py"
                        (("SWFRENDER_PATH = .*\n")
                         (string-append "SWFRENDER_PATH = \"" swfrender "\"\n")))
                      (substitute* "HydrusVideoHandling.py"
                        (("FFMPEG_PATH = .*\n")
                         (string-append "FFMPEG_PATH = \"" ffmpeg "\"\n")))
                      (substitute* "networking/HydrusNATPunch.py"
                        (("UPNPC_PATH = .*\n")
                         (string-append "UPNPC_PATH = \"" upnpc "\"\n"))))))))
            ;; Since everything lives in hydrus's root directory, it needs to
            ;; be spread out to comply with guix's expectations.
            (replace 'install
              (lambda* (#:key outputs #:allow-other-keys)
                (let* ((out (assoc-ref outputs "out"))
                       (client (string-append out "/bin/hydrus"))
                       (server (string-append out "/bin/hydrus-server")))
                  (copy-recursively "static"
                                    (string-append out static-dir))
                  (copy-recursively "hydrus"
                                    (string-append out
                                                   "/lib/python"
                                                   (python-version
                                                    #$(this-package-input "python"))
                                                   "/site-packages/hydrus"))
                  (mkdir (string-append out "/bin"))
                  (copy-file "client.py" client)
                  (chmod client #o0555)
                  (copy-file "server.py" server)
                  (chmod server #o0555))))))))
    ;; All native-inputs are only needed for the the check phase
    (native-inputs
     (list xvfb-run
           python-nose
           python-mock
           python-httmock))
    ;; All python packages were taken from static/build_files/linux/requirements.txt
    (propagated-inputs
     (list python-beautifulsoup4
           python-cbor2
           python-chardet
           python-cloudscraper
           python-html5lib
           python-lxml
           python-lz4
           python-numpy
           opencv ; its python bindings are a drop-in replacement for opencv-python-headless
           python-pillow
           python-psutil
           python-pylzma
           python-pyopenssl
           ;; Since hydrus' version 494 it supports python-pyside-6 but it's not yet
           ;; in guix. pyside-2 is still supported as a fallback.
           python-pyside-2
           python-pysocks
           python-mpv
           python-pyyaml
           python-qtpy
           python-requests
           python-send2trash
           python-service-identity
           python-six
           python-twisted))
    (inputs
     (list swftools ffmpeg miniupnpc python))
    (synopsis "Organize your media with tags like a dektop booru")
    (description
     "The hydrus network client is an application written for
internet-fluent media nerds who have large image/swf/webm collections.
It browses with tags instead of folders, a little like a booru on your desktop.
Advanced users can share tags and files anonymously through custom servers that
any user may run.  Everything is free and privacy is the first concern.")
    (home-page "https://hydrusnetwork.github.io/hydrus/")
    (license license:wtfpl2)))
