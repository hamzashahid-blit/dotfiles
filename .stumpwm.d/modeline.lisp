    (in-package :stumpwm)

;; (when *initializing*
;;   (mode-line))

(setf *window-format* "%m%34t%m" ; How to show windows; 25 chars for name
      *hidden-window-color* "^(:fg \"#bdae93\")"
      *group-format* "%t") ;"%n%s%t"

;; For some reason, StumpWM kind of ignores these but likes *screen-mode-line-format*
(setf *mode-line-foreground-color* "#ebdbb2"
      *mode-line-background-color* "#282828"
      *mode-line-highlight-template*
        (format nil "^(:bg 4) ~~A ^(:bg \"#282828\")") ; Selected Window Color «»
      *mode-line-border-color*     "#504945")

(load-module "cpu")
(load-module "mem")
;(load-module "net")

;; TODO: Net Module
(setf cpu::*cpu-modeline-fmt* "%C"
      cpu::*cpu-usage-modeline-fmt* "CPU: ^[~A~3D%^]" ;^f2^f0^[~A~2D%^]
      mem::*mem-modeline-fmt* "%a%p")

;; Change color of value as it inc/dec with (bar-zone-color)
(setf *bar-med-color* "^b^(:fg \"#83a598\")"
      *bar-hi-color* "^b^(:fg \"#fabd2f\")"
      *bar-crit-color* "^b^(:fg \"#fb4934\")")

(defun hamza/fmt-cpu-usage ()
  "Returns a string representing current the percent of average CPU
  utilization. BUT it is a float rounded to the TENTH place. Also colors."
  (let ((cpu (* 100 (cpu::current-cpu-usage))))
    (format nil "cpu: ^(:fg \"#b8bb26\")~A~1$%" (bar-zone-color cpu) cpu)))

(defun hamza/fmt-mem-usage ()
  "Returns a string representing the current percent of used memory,
Except, it's in my format (Gruvbox colors)"
  (let ((mem (* 100 (third (mem::mem-usage)))))
    (format nil "mem: ^(:fg \"#b8bb26\")~A~1$%" (bar-zone-color mem) mem)))

;; You could try %d for time and set
;; TODO: Remove the %M and %C and directly use the
;;       module's functions with format
;; TODO: Create a generate modeline function which handles colors
(setf stumpwm:*screen-mode-line-format*
  (list "^(:fg \"#ebdbb2\")%g ^(:fg \"#bdae93\")| "
        "^(:fg \"#ebdbb2\")%v^>"
        ;; Right side
        '(:eval (hamza/fmt-cpu-usage))
        "^(:fg \"#bdae93\") | ^(:fg \"#ebdbb2\")"
        '(:eval (hamza/fmt-mem-usage))
        "^(:fg \"#bdae93\") | ^(:fg \"#fe8019\")"
        '(:eval (async-run "date +\"%I:%M %p :%S\""))
        "^(:fg \"#bdae93\") | ^(:fg \"#fe8019\")"
        '(:eval (async-run "date +\"%b %d, %a (%Y)\""))))
    
(when *initializing*
  (mode-line))

(setf (timer-repeat *mode-line-timer*) 0.5 ;; Refresh every second
      *mode-line-timeout* 0.5)

(update-all-mode-lines)
