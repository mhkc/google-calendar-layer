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
        "agf" 'org-gcal-fetch)))

  ;; Add hook for automatic fetch and sync
  (add-hook 'after-init-hook 'org-gcal-fetch)
  (add-hook 'kill-emacs-hook 'org-gcal-sync)
  (add-hook 'org-capture-after-finalize-hook 'google-calendar/sync-cal-after-capture)
  (run-with-idle-timer 600 t 'org-gcal-update))

(defun google-calendar/init-calfw ()
  "Initialize calfw"
  (use-package calfw-org
    :init
    (setq google-calendar-agenda-view "a")
    (progn
      (spacemacs/set-leader-keys
        "agc" '(lambda () (org-agenda nil google-calendar-agenda-view)(cfw:open-org-calendar))))
    :commands
    (cfw:open-org-calendar)
    ))

(defun google-calendar/init-alert ()
  "Initialize alert"
  (use-package alert
    :defer t
    :init
    (setq alert-default-style 'libnotify)))

(defun google-calendar/init-f ()
  "Initialize alert"
  (use-package f))

;;; packages.el ends here
