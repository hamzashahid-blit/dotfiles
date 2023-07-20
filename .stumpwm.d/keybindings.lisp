;;;; Keybindings 
(in-package :stumpwm)

(set-prefix-key (kbd "C-;"))
     
;; Run Command; Since "C-; ;" was overrided
(define-key *root-map* (kbd "C-s") "colon")
(define-key *root-map* (kbd "C-e") "launch \"emacsclient -c -a ''\"")
(define-key *root-map* (kbd "c") "launch alacritty") ;; Terminal

(define-key *root-map* (kbd "C-y") "mpv-clipboard")
(define-key *root-map* (kbd "y") "mpv-link")
(define-key *root-map* (kbd "C-q") "launch \"alacritty -e qalc\"")
(undefine-key *root-map* (kbd "x"))
(define-key *root-map* (kbd "x") "launch \"scrot ~/pix/scrots/%y%b%d-%H:%M:%S.png\"")
(define-key *root-map* (kbd "C-X") "launch \"scrot -s ~/pix/scrots/%y%b%d-%H:%M:%S.png\"")
(undefine-key *root-map* (kbd "C-m"))
(define-key *root-map* (kbd "C-m") "launch /home/hamza/shl/mount-usb.sh")
(define-key *root-map* (kbd "C-M") "launch /home/hamza/shl/unmount-usb.sh")


(undefine-key *root-map* (kbd "v"))
(define-key *root-map* (kbd "V") "version")
(define-key *root-map* (kbd "v") "launch \"copyq toggle\"")


;; ;; Replace "select-window" (C-') (for some reason showing as C->) with Rofi
;; (undefine-key *root-map* (kbd "C-'"))
;; (define-key *root-map* (kbd "C-'") "launch \"rofi -show window\"")
;; (define-key *root-map* (kbd "C-M->") "select-window")

(undefine-key *root-map* (kbd "w"))
(undefine-key *root-map* (kbd "e"))
(define-key *root-map* (kbd "w") "launch \"rofi -show window\"")

;; Replace running programs with Rofi
;; (define-key *root-map* (kbd "C-f") "launch \"rofi -show run\"")
(define-key *root-map* (kbd "C-f") "launch \"dmenu_run\"") ;; DOESN'T WORK When: -nb #282828 -nf #ebdbb2 -sb #665c54 -sf #fbf1c7
(define-key *root-map* (kbd "C-x") *exchange-window-map*)
(define-key *root-map* (kbd "C-M-f") "exec")

;; Groups
(undefine-key *root-map* (kbd "1"))
(undefine-key *root-map* (kbd "2"))
(undefine-key *root-map* (kbd "3"))
(undefine-key *root-map* (kbd "4"))
(undefine-key *root-map* (kbd "5"))
(undefine-key *root-map* (kbd "6"))
(undefine-key *root-map* (kbd "7"))
(undefine-key *root-map* (kbd "8"))
(undefine-key *root-map* (kbd "0"))

(define-key *root-map* (kbd "1") "gselect 1")
(define-key *root-map* (kbd "2") "gselect 2")
(define-key *root-map* (kbd "3") "gselect 3")
(define-key *root-map* (kbd "4") "gselect 4")
(define-key *root-map* (kbd "5") "gselect 5")
(define-key *root-map* (kbd "6") "gselect 6")
(define-key *root-map* (kbd "7") "gselect 7")
(define-key *root-map* (kbd "8") "gselect 8")
(define-key *root-map* (kbd "0") "gselect 9")

;;; Windows
;; OLD: C-h, C-j, C-k, C-l = Move between frames
;; NEW: S-h, S-j, S-k, S-l = Move between frames
;; h, l = Move between Groups
;; j, k OR C-S-j C-S-k = Move between windows in frame

(undefine-key *root-map* (kbd "k")) ;; Old kill
(define-key *root-map* (kbd "j") "pull-hidden-next")
(define-key *root-map* (kbd "k") "pull-hidden-previous")

(undefine-key *root-map* (kbd "h")) ;; Old help-map
(undefine-key *root-map* (kbd "l")) ;; Old redisplay
(define-key *root-map* (kbd "h") "gprev")
(define-key *root-map* (kbd "l") "gnext")
(define-key *top-map* (kbd "H-n") "gnext")
(define-key *top-map* (kbd "H-p") "gprev")

(define-key *top-map* (kbd "H-C-j") "pull-hidden-next")
(define-key *top-map* (kbd "H-C-k") "pull-hidden-previous")

(define-key *top-map* (kbd "H-h") "move-focus left")
(define-key *top-map* (kbd "H-j") "move-focus down")
(define-key *top-map* (kbd "H-k") "move-focus up")
(define-key *top-map* (kbd "H-l") "move-focus right")

(define-key *top-map* (kbd "M-TAB") "pull-hidden-other")

;; Help map = H
;; quick help = ?, C-h
(undefine-key *root-map* (kbd "C-h")) ;; Old keybindings show like '?'
(undefine-key *root-map* (kbd "C-l")) ;; Old redisplay
(undefine-key *root-map* (kbd "C-k")) ;; Old delete
(define-key *root-map* (kbd "H") *help-map*)
(define-key *root-map* (kbd "L") "redisplay")
(define-key *root-map* (kbd "d") "delete")
(define-key *root-map* (kbd "C-d") "kill")

;; (define-key *root-map* (kbd "C-h") "move-focus left")
;; (define-key *root-map* (kbd "C-j") "move-focus down")
;; (define-key *root-map* (kbd "C-k") "move-focus up")
;; (define-key *root-map* (kbd "C-l") "move-focus right")

(undefine-key *root-map* (kbd "s")) ;; Old vsplit
(undefine-key *root-map* (kbd "S")) ;; Old hsplit
(define-key *root-map* (kbd "s") "hsplit-and-focus")
(define-key *root-map* (kbd "S") "vsplit-and-focus")

(undefine-key *root-map* (kbd "r")) ;; Old Resize
(undefine-key *root-map* (kbd "R")) ;; Old Remove frame
(define-key *root-map* (kbd "r") "remove")
(define-key *root-map* (kbd "R") "iresize")

;; Extra
;; (undefine-key *root-map* (kbd "b")) ;; Old ???? whatkwlasjdflsf
;; (define-key *root-map* (kbd "b") "mode-line")
(define-key *groups-map* (kbd "G") "toggle-gaps")
