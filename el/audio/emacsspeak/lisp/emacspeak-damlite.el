;;; emacspeak-damlite.el --- Speech-enable damlite
;;; $Id: emacspeak-damlite.el 4074 2006-08-19 17:48:45Z tv.raman.tv $
;;; $Author: tv.raman.tv $
;;; Description:  Emacspeak front-end for daml  authoring mode 
;;; Keywords: Emacspeak, damlite 
;;{{{  LCD Archive entry:

;;; LCD Archive Entry:
;;; emacspeak| T. V. Raman |raman@cs.cornell.edu
;;; A speech interface to Emacs |
;;; $Date: 2006-08-19 10:48:45 -0700 (Sat, 19 Aug 2006) $ |
;;;  $Revision: 4074 $ |
;;; Location undetermined
;;;

;;}}}
;;{{{  Copyright:

;;; Copyright (C) 1999 T. V. Raman <raman@cs.cornell.edu>
;;; All Rights Reserved.
;;;
;;; This file is not part of GNU Emacs, but the same permissions apply.
;;;
;;; GNU Emacs is free software; you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 2, or (at your option)
;;; any later version.
;;;
;;; GNU Emacs is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with GNU Emacs; see the file COPYING.  If not, write to
;;; the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.

;;}}}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Commentary:
;;{{{  Introduction:

;;; Speech-enables package damlite --
;;; daml mode is used to author and maintain daml ontologies
;;; using RDF

;;}}}
;;{{{ required modules

;;; Code:
(require 'emacspeak-preamble)
;;}}}
;;{{{ define personalities 

(voice-setup-add-map
 '(
   (daml-class-face voice-smoothen)
   (daml-class-ref-face voice-lighten)
   (daml-comment-face voice-monotone)
   (daml-keyword-face voice-animate-extra)
   (daml-normal-face (quote paul))
   (daml-other-face (quote voice-bolden-extra))
   (daml-property-face voice-animate)
   (daml-property-ref-face voice-animate-extra)
   (daml-string-face voice-lighten-extra)
   (daml-substitution-face voice-smoothen)
   (daml-tag-face voice-bolden)
   ))

;;}}}
(provide 'emacspeak-damlite)
;;{{{ end of file

;;; local variables:
;;; folded-file: t
;;; byte-compile-dynamic: t
;;; end:

;;}}}
