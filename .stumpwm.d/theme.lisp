(in-package :stumpwm)

;;; Gruvbox dark
(setf *colors*
      '("#282828"   ;black #1d2021
        "#cc241d"   ;red
        "#98971a"   ;green "#b8bb26"
        "#d79921"   ;yellow
        "#83a598"   ;blue "#458588"
        "#d3869b"   ;magenta "#b16286" (I used purple)
        "#689d6a"   ;cyan (i did aqua)
        "#ebdbb2")) ;white

;; (setf *default-bg-color* "#282828")
;; (setf *default-fg-color* "#ebdbb2")
(set-bg-color "#282828")
(set-fg-color "#ebdbb2")
(update-color-map (current-screen))

(set-border-color        "#b16286") ; Message & Input borders
(set-focus-color         "#b16286") ; Normal focus border
(set-unfocus-color       "#282828") ; Unfocused windows
(set-float-focus-color   "#b16286")
(set-float-unfocus-color "#282828")

;; (load-module "ttf-fonts")
;; (set-font "-b&h-lucidatypewriter-medium-r-normal-sans-11-80-100-100-m-70-iso10646-1")
;; (set-bg-color "black")
;; (set-fg-color "antiquewhite")
;; (set-border-color "lightgreen")
;; (set-unfocus-color "darkgray")

;; Fonts
;(ql:quickload :truetype-clx)
;; (load-module "ttf-fonts")
;(xft:cache-fonts) ; Run once? or maybe every time? Check for cache?
;(clx-truetype:get-font-families) ;; DejaVu Sans, Book | mononoki, Regular

;(set-font `(,(make-instance 'xft:font
;                            :family "mononoki"
;                            :subfamily "Regular"
;                            :size 11
;                            :antialias t)
;            ;; ,(make-instance 'xft:font
;            ;;                 :family "DejaVu Sans Mono for Powerline"
;            ;;                 :subfamily "Book"
;            ;;                 :size 8.5
;            ;;                 :antialias t)
;            ,(make-instance 'xft:font
;                            :family "DejaVu Sans"
;                            :subfamily "Book"
;                            :size 8.5
;                            :antialias t)))


;;; Pointer when Prefix key is pressed
;; Square = 64, 65
;; Heart  = 64, 62 
;; Arrows = 50, 51
(setf *grab-pointer-character* 64
      *grab-pointer-character-mask* 65) 
