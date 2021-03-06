;;; sb-zeit-de.el --- shimbun backend for <http://www.zeit.de>

;; Copyright (C) 2004, 2005, 2006 Andreas Seltenreich <seltenreich@gmx.de>

;; Author: Andreas Seltenreich <seltenreich@gmx.de>
;; Keywords: news
;; Created: May 23, 2004

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; if not, you can either send email to this
;; program's maintainer or write to: The Free Software Foundation,
;; Inc.; 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.

;;; Code:

(require 'shimbun)
(require 'sb-rss)

(luna-define-class shimbun-zeit-de (shimbun-rss) ())

(defvar shimbun-zeit-de-groups
  '("chancen" "dossier" "hochschule" "leben" "literatur" "media"
    "news" "politik" "reden" "reisen" "wirtschaft" "wissen"
    "wohlfuehlen" "zeitlaeufte"
))

(defvar shimbun-zeit-de-content-start
  "title\">\\|<!--content starts here-->\\(?:<table[^>]+>\\)?")

(defvar shimbun-zeit-de-content-end
  (concat
   "</body>\\|</html>\\|navigation[^><]*>[^A]\\|"
   "<script language=\"JavaScript1\.2\" type=\"text/javascript\">"))

(defvar shimbun-zeit-de-from-address "DieZeit@zeit.de")

(luna-define-method shimbun-headers :before ((shimbun shimbun-zeit-de)
					     &rest range)
  shimbun)

(luna-define-method shimbun-groups ((shimbun shimbun-zeit-de))
  shimbun-zeit-de-groups)

(luna-define-method shimbun-get-headers :around ((shimbun shimbun-zeit-de)
						 &optional range)
  (mapc
   (lambda (header)
     (let ((url (shimbun-header-xref header)))
       (cond ((string-match "\\`http://www\\.zeit\\.de" url)
	      (shimbun-header-set-xref header (concat url "?page=all")))
	     ((string-match "\\`/" url)
	      (shimbun-header-set-xref
	       header (concat "http://www.zeit.de" url))))))
   (luna-call-next-method)))

(luna-define-method shimbun-make-contents :before ((shimbun shimbun-zeit-de)
						   header)
  (let* ((case-fold-search t)
	 (start (re-search-forward (shimbun-content-start shimbun) nil t))
	 (end (and start
		   (re-search-forward (shimbun-content-end shimbun) nil t)
		   (prog1
		       (match-beginning 0)
		     (goto-char start)))))
    (setq case-fold-search nil)
    (when (re-search-forward "(c)[^Z]*ZEIT[^0-9]*\
\\([0-3][0-9]\\)\\.\\([01][0-9]\\)\\.\\(20[0-9][0-9]\\)"
			     end t)
      (shimbun-header-set-date
       header
       (shimbun-make-date-string (string-to-number (match-string 3))
				 (string-to-number (match-string 2))
				 (string-to-number (match-string 1))
				 nil
				 "+02:00"))
      (goto-char (point-min)))))

(luna-define-method shimbun-index-url ((shimbun shimbun-zeit-de))
  (let ((group (shimbun-current-group shimbun)))
    (if (equal "news" group)
	"http://newsfeed.zeit.de/"
      (concat "http://newsfeed.zeit.de/" group "/index"))))

(luna-define-method shimbun-clear-contents :after ((shimbun shimbun-zeit-de)
						    header)

  ;;  remove advertisements and 1-pixel-images aka webbugs
  (shimbun-remove-tags "<a[^>]*doubleclick.net" "</a>")
  (shimbun-remove-tags "<IFRAME[^>]*doubleclick.net[^>]*>")
  (shimbun-remove-tags "<img[^>]*doubleclick.net[^>]*>")
  (shimbun-remove-tags "<img[^>]*\\(width\\|height\\)=\"1px\"[^>]*>")
  (shimbun-remove-tags "<tr><td[^>]*>Anzeige</td></tr>")
  t)

(provide 'sb-zeit-de)

;;; sb-zeit-de.el ends here
