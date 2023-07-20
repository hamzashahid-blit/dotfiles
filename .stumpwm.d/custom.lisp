(in-package :stumpwm)

(defparameter *update-session-p* nil)

(defcommand delete-window-and-frame () ()
  "Delete the current frame with it's window."
  (delete-window)
  (remove-split))

(defcommand hsplit-and-focus () ()
  "Create a new frame on the right and focus it."
  (hsplit)
  (move-focus :right))

(defcommand vsplit-and-focus () ()
  "Create a new frame below and focus it."
  (vsplit)
  (move-focus :down))

(defcommand launch (program)
    ((:string "Program to run: "))
  "Launch any Program asynchronously with UIOP:LAUNCH-PROGRAM instead of built-in exec command"
  (uiop:launch-program program))

;; Really proud of myself.
(defcommand rasheed-is-okay (&optional (delay 3))
    ((:number nil))
  (fire-search "Rasheed is Okay." delay))

(defcommand fire-search (to-search &optional (delay 3))
    ((:string "What do you want to search? ")
     (:number nil)) ; Optional delay 
  (uiop:launch-program "firefox")
  (run-with-timer delay nil
    (lambda ()
      (format t "Launched Firefox!~%")
      (select-window-by-name "Mozilla Firefox")
      (send-fake-key (current-window) (kbd "C-t"))
      (window-send-string to-search)
      (send-fake-key (current-window) (kbd "RET")))))

(defcommand watch-news (news)
    ((:string "Type a number
1 - ARY
2 - BOL
3 - 92 News
0 - YouTube
Otherwise enter URL: "))
  (handler-case (parse-integer news)
    (error ()
      (uiop:launch-program (format nil "firefox ~a" news))
      (return-from watch-news 0)))

  (let ((news-num (parse-integer news)))
    (cond
      ((= news-num 1) (uiop:launch-program "firefox https://www.youtube.com/watch?v=38IEolI8f-w"))
      ((= news-num 2) (uiop:launch-program "firefox https://www.youtube.com/watch?v=VXW5mjCU3sQ"))
      ((= news-num 3) (uiop:launch-program "firefox https://www.youtube.com/watch?v=Z_druZFx1-Y"))
      ((= news-num 0) (uiop:launch-program "firefox https://www.youtube.com"))
      (t (eval-command "launch-youtube")))))

(defcommand launch-youtube (bool)
    ((:y-or-n "You entered an invalid number or URL.
Do you want to launch YouTube? "))
  (when bool
    (uiop:launch-program "firefox https://www.youtube.com")))

(defcommand mpv-link (link)
  ((:string "Enter Link: "))
  (uiop:launch-program (format nil "mpv --ytdl-raw-options=format-sort='res:1080' ~a" link)))

(defcommand mpv-clipboard () ()
  (uiop:launch-program (format nil "mpv --ytdl-raw-options=format-sort='res:1080' ~a" (piped->youtube (get-clipboard)))))

(defun get-clipboard ()
  (with-output-to-string (out)
	(let ((stream (uiop:process-info-output (uiop:launch-program "xclip -selection clipboard -o" :output :stream))))
	  (loop :for c = (peek-char t stream nil nil)
            :while c
            :do (write-char (read-char stream) out)))))

(defun piped->youtube (link)
  (str:replace-first "il.ax" "youtube.com" link))

;; (defun update-session (window)
;;   (when *update-session-p* 
;;     (dump-desktop-to-file "~/.stumpwm.d/.mysession")))

;; (add-hook *new-window-hook* 'update-session)

;; (defcommand restore-session () ()
;;   (restore-desktop (read-dump-from-file "~/.stumpwm.d/.mysession")))



;; Reference to a command which sets up the environment for your current project
;; (defcommand work () ()
;;   (uiop:run-program "emacsclient -c -a ''"))
