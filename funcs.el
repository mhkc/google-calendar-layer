;;; funcs.el --- google-calendar Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Markus Johansson markus.johansson@me.com
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(when (configuration-layer/package-usedp 'org-gcal)
  (defun google-calendar/org-gcal-update ()
    "Refresh OAuth token, fetch and sync calendar"
    (interactive)
    (org-gcal-refresh-token)
    (org-gcal-fetch))

  (defun google-calendar/sync-cal-after-capture ()
    "Sync calendar after a event was added with org-capture.
The function can be run automatically with the 'org-capture-after-finalize-hook'."
    (when-let ((cal-files (mapcar 'f-expand (mapcar 'cdr org-gcal-file-alist)))
               (capture-target (f-expand (car (cdr (org-capture-get :target)))))
               (cal-file-exists (and (mapcar 'f-file? cal-files)))
               (capture-target-isfile (eq (car (org-capture-get :target)) 'file))
               (capture-target-is-cal-file (member capture-target cal-files)))
      (org-gcal-refresh-token)
      (org-gcal-post-at-point))))
