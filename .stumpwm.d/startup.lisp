(in-package :stumpwm)

;; Random wallpaper
(let* ((wallpaper-dir #p"~/pix/walls/")
	   (wallpaper-pathnames (uiop:directory-files wallpaper-dir))
	   (random-index (random (length wallpaper-pathnames)))
	   (random-wallpaper-pathname (elt wallpaper-pathnames random-index))
	   (random-wallpaper-pathname-string (uiop:native-namestring random-wallpaper-pathname))
	   (command-string (format nil "hsetroot -fill \"~a\"" random-wallpaper-pathname-string)))
  (uiop:launch-program command-string))

(uiop:launch-program "picom")

(setf *startup-message*
  "^(:fg \"#ebdbb2\")Welcome to ^(:fg 4)^BH^(:fg \"#83a598\")amza's ^(:fg 4)^BPC ^(:fg \"#ebdbb2\")and ^B^(:fg 3)^BStump^b ^BW^bindow ^BM^banager^(:fg \"#ebdbb2\")!
^b^(:fg \"#ebdbb2\")For help, press ^(:fg \"#d3869b\")~a ?")
(message *startup-message* (print-key *escape-key*))


;; (uiop:launch-program "date --set='+3 minutes 36.1 seconds'") ;; solved by ntpd
(uiop:launch-program "emacsclient -c -a ''")
(uiop:launch-program "qutebrowser")
(uiop:launch-program "element-desktop")
(uiop:launch-program "keepassxc")
(uiop:launch-program "qbittorrent")

(slynk-start-server 1234)

(run-with-timer 15 nil
  (lambda () (setf *update-session-p* t)))
