;;; packages.el --- google-calendar layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Markus Johansson <markus.johansson@me.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

(defconst google-calendar-packages
  '(org-gcal
    calfw
    alert
    f))

(defun google-calendar/init-org-gcal ()
  "Initializes org-gcal and adds keybindings for it's exposed functions"
  (use-package org-gcal
    :init
    (progn
      (spacemacs/set-leader-keys
        "agr" 'org-gcal-refresh-token
        "ags" 'org-gcal-sync
        "agf" 'org-gcal-fetch))
    :config
    (add-hook 'after-init-hook 'org-gcal-fetch)
    (add-hook 'kill-emacs-hook 'org-gcal-sync)
    (add-hook 'org-capture-after-finalize-hook 'google-calendar/sync-cal-after-capture)
    (run-with-idle-timer 600 t 'google-calendar/org-gcal-update)))

(defvar google-calendar-agenda-view "a")

(defun google-calendar/init-calfw ()
  "Initialize calfw"
  (use-package calfw-org
    :init
    (spacemacs/set-leader-keys
      "agc" 'google-calendar/calfw-view)
    (spacemacs/declare-prefix "agc" "open-org-calendar")
    :commands
    (cfw:open-org-calendar)))

(defun google-calendar/calfw-view ()
  (interactive)
  (org-agenda nil google-calendar-agenda-view)
  (cfw:open-org-calendar))

(defun google-calendar/init-alert ()
  "Initialize alert"
  (use-package alert
    :defer t
    :init
    (setq alert-default-style 'notifications)))

(defun google-calendar/init-f ()
  "Initialize f"
  (use-package f))

;;; packages.el ends here
