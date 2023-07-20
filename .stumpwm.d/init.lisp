;;; StumpWM's Init file
;;; Author: Hamza Shahid

;; TODO: Make an installation script that runs:
;; $ cd ~/quicklisp/local-projects/
;; $ git clone https://github.com/lihebi/clx-truetype.git
;; TODOOOOOOOOO: Create global variables for browser etc. to not have to change it everywhere
;; TODOOOOOOOO:  Remember all open windows and save to a file. Open it again on startup.
;; TODOOOOOOO:   Properly handle floating and layout
;; TODOOOOOO:    Make smart "gmove" (auto if only 2 groups; Don't list current group)
;; TODOOOOO:     Block everything on Namaz timings (+ 5 mins for azaan to finish)
;; TODOOO:       cpu & mem icons
;; DONE: Auto start slynk for config maybe.
;; HALT: Remove gaps when there is no split. (or find a better solution?) (I Removed Gaps?????)
;; DONE: Don't kill process of emacs easily with 'd'
;; DONE: Put under git

(in-package :stumpwm)
(ql:quickload :str)
(setf *default-package* :stumpwm)

;; "^2*Welcome to The ^BStump^b ^BW^bindow ^BM^banager!
;; Press ^5*~a ?^2* for help."

;; We set to NIL for now to supress and in startup.lisp after everything is loaded,
;; we set the *startup-message* and show it.
(setf *startup-message* nil)
;; Indicate modules path
(init-load-path "~/.stumpwm.d/")

(defparameter *async-shell* (uiop:launch-program "bash" :input :stream :output :stream))
(defun async-run (command)
  (write-line command (uiop:process-info-input *async-shell*))
  (force-output (uiop:process-info-input *async-shell*))
  (let* ((output-string (read-line (uiop:process-info-output *async-shell*)))
         (stream (uiop:process-info-output *async-shell*)))
    (if (listen stream)
        (loop while (listen stream)
              do (setf output-string (concatenate 'string
                                                  output-string
                                                  '(#\Newline)
                                                  (read-line stream)))))
    output-string))

;; (which-key-mode)

(load "~/.stumpwm.d/keybindings.lisp")
(load "~/.stumpwm.d/theme.lisp")
(load "~/.stumpwm.d/windows.lisp")
(load "~/.stumpwm.d/modeline.lisp")
(load "~/.stumpwm.d/custom.lisp")
(load "~/.stumpwm.d/slynk.lisp")
(load "~/.stumpwm.d/startup.lisp")
