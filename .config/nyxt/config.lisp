(defvar *my-search-engines*
  (list
   '("au" "https://priv.au/search?q=~a" "https://priv.au")
   '("google" "https://google.com/search?q=~a" "https://google.com")
   '("python3" "https://docs.python.org/3/search.html?q=~a"
     "https://docs.python.org/3")
   '("doi" "https://dx.doi.org/~a" "https://dx.doi.org/"))
  "List of search engines.")

(define-configuration browser
  ((theme theme:+dark-theme+ :doc "Setting dark theme")))

;; (define-configuration browser
;;   ((theme (make-instance
;;            'theme:theme
;;            :dark-p t
;;            :background-color "#282a36"
;;            :text-color "#f8f8f2"
;;            :accent-color "#ff5555"
;;            :primary-color "#50fa7b"
;;            :secondary-color "#bd93f9"
;;            :tertiary-color "#6272a4"
;;            :quaternary-color "#44475a"))))

;; ;; Custom Dark-mode for webpages
;; (define-configuration nyxt/style-mode:dark-mode
;;   ((style #.(cl-css:css
;;              '((*
;;                 :background-color "#282a36 !important"
;;                 :background-image "none !important"
;;                 :color "#f8f8f2")
;;                (a
;;                 :background-color "#282a36 !important"
;;                 :background-image "none !important"
;;                 :color "#6272a4 !important"))))))
