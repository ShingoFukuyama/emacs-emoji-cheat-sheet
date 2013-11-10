;;; emoji-cheat-sheet.el --- emoji-cheat-sheet for emacs -*- coding: utf-8; lexical-binding: t -*-

;; Copyright (C) 2013 by Shingo Fukuyama

;; Version: 1.0
;; Author: Shingo Fukuyama - http://fukuyama.co
;; URL: https://github.com/ShingoFukuyama/emoji-cheat-sheet
;; Created: Nov 9 2013
;; Keywords: emacs emoji cheat sheet
;; Package-Requires: (emacs "24")

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2 of
;; the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be
;; useful, but WITHOUT ANY WARRANTY; without even the implied
;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
;; PURPOSE.  See the GNU General Public License for more details.

;;; Commentary:

;; You can choose emojis (listed on http://www.emoji-cheat-sheet.com/)
;; from emacs

;; Setting
;; (add-to-list 'load-path "/path/to/emacs-emoji-cheat-sheet")
;; (require 'emoji-cheat-sheet)

;; Images from arvida/emoji-cheat-sheet.com
;; https://github.com/arvida/emoji-cheat-sheet.com

;; octocat, squirrel, shipit
;; Copyright (c) 2012 GitHub Inc. All rights reserved.
;; bowtie
;; Copyright (c) 2012 37signals, LLC. All rights reserved.
;; neckbeard
;; Copyright (c) 2012 Jamie Dihiansan. Creative Commons Attribution 3.0 Unported
;; feelsgood, finnadie, goberserk, godmode, hurtrealbad, rage 1-4, suspect
;; Copyright (c) 2012 id Software. All rights reserved.
;; trollface
;; Copyright (c) 2012 whynne@deviantart. All rights reserved.
;; All other emoji images
;; Copyright (c) 2012 Apple Inc. All rights reserved.

;;; Code:

(eval-when-compile (require 'cl))

(defvar emoji-cheat-sheet-dir
  (concat (file-name-directory (or load-file-name (buffer-file-name)))
   "emoji-cheat-sheet/"))

(defun emoji-cheat-sheet-create ()
  (let (($files (directory-files emoji-cheat-sheet-dir nil "png$"))
        ($i 0)
        ($width (window-width)))
    (dolist ($file $files)
      (insert-image (create-image (concat emoji-cheat-sheet-dir $file)
                                  'png nil :margin 1 :ascent 'center)
                    (format ":%s:" (substring $file 0 -4)))
      (setq $i (1+ $i))
      (if (eq 0 (% $i (/ $width 4)))
          (insert "\n")))))

(defun emoji-cheat-sheet-copy-at-point ()
  (interactive)
  (let (($po (point)) $code)
    (execute-kbd-macro (kbd "<right>"))
    (kill-new (setq $code (buffer-substring-no-properties $po (point))))
    (execute-kbd-macro (kbd "<left>"))
    (message (format "Copy `%s' to clipboard" $code))))

;;;###autoload
(defun emoji-cheat-sheet ()
  (interactive)
  (with-current-buffer (get-buffer-create "*emoji*")
    (read-only-mode 0)
    (erase-buffer)
    (pop-to-buffer (current-buffer))
    (insert (concat "From: http://www.emoji-cheat-sheet.com/\n"
                    "Press `RET' key on any emoji to copy its code.\n"
                    "----------------------------------------------\n"))
    (emoji-cheat-sheet-create)
    (local-set-key (kbd "RET") 'emoji-cheat-sheet-copy-at-point)
    (goto-char (point-min))
    (read-only-mode 1)))

(provide 'emoji-cheat-sheet)
;;; emoji-cheat-sheet.el ends here
