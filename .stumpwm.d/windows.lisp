(in-package :stumpwm)

;; Starting Group
(setf *input-window-gravity* :top
      *message-window-gravity* :top
      *window-border-style* :thick
      *message-window-padding* 7
      *message-window-y-padding* 7
      *maxsize-border-width* 1
      *normal-border-width* 1
      *transient-border-width* 1
      *float-window-border* 1
      *float-window-title-height* 1
      *suppress-frame-indicator* t      ; 'Current Frame' message
      *mouse-focus-policy* :click      ; Focus follows mouse
      *float-window-modifier* :super)

;; (clear-window-placement-rules)

(when *initializing*
  (grename "Main")
  (gnew "Extra")
  (gnew "Study +_+")
  (gnew "Break UwU")
  (gselect "1"))

;;; Gaps [DISABLED]
;; (load-module "swm-gaps")
;; (setf swm-gaps:*head-gaps-size* 0
;;       swm-gaps:*inner-gaps-size* 3
;;       swm-gaps:*outer-gaps-size* 10)

;; (when *initializing*
;;   (swm-gaps:toggle-gaps))
