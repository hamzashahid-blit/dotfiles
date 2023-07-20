(define-configuration buffer
  ((default-modes
    (pushnew 'nyxt/vi-mode:vi-normal-mode %slot-value%))))

(define-configuration prompt-buffer
  ((default-modes
    (append '(nyxt/vi-mode:vi-insert-mode) %slot-default%))))



;; (define-configuration buffer
;;  ((default-modes (append '(nyxt::vi-normal-mode) %slot-default%))))

;; (define-configuration prompt-buffer
;;  ((default-modes (append '(nyxt::vi-insert-mode) %slot-default%))))

;; (defmethod customize-instance ((input-buffer input-buffer) &key)
;;   (disable-modes* 'nyxt/emacs-mode:emacs-mode input-buffer)
;;   (enable-modes* 'nyxt/vi-mode:vi-normal-mode input-buffer))
;; (setf (uiop/os:getenv "WEBKIT_DISABLE_COMPOSITING_MODE") "1")
;; (defmethod customize-instance
;;            ((nyxt/hint-mode:hint-mode nyxt/hint-mode:hint-mode) &key)
;;   (setf (slot-value nyxt/hint-mode:hint-mode 'nyxt/hint-mode:hints-alphabet)
;;           "asdfghjkl;"))
