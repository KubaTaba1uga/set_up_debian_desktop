;;Packages

; start package.el 
(require 'package)

; add MELPA repository list
(add-to-list 'package-archives '("melpa"."https://melpa.org/packages/")t)
; initializae package.el(package-initialize)
; dependencies to install
(defvar myPackages
  '(
    ; themas
    solarized-theme
    powerline
    flycheck-color-mode-line
    afternoon-theme

    ; global dependencies
    exec-path-from-shell
    use-package
    auto-complete
    yasnippet
    yasnippet-snippets
    flycheck
    flycheck-inline
    flycheck-pos-tip
    flycheck-popup-tip
    nav
    centaur-tabs
    company
    company-quickhelp
    
    ; C dependencies
    auto-complete-c-headers
    google-c-style
    flycheck-clang-analyzer
    clang-format
    company-irony-c-headers
    company-irony
    irony
    irony-eldoc

    ; python dependencies
    elpy
    py-autopep8
    jedi
    jedi-direx
    python-black
    flycheck-mypy))

; install all dependencies
(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-install package)))
      myPackages)

; start using environment variables
(package-install 'exec-path-from-shell)
(exec-path-from-shell-initialize)

;;Thema

; configure solarized thema
; make the modeline high contrast
(setq solarized-high-contrast-mode-line t)
;use more italics
(setq solarized-use-more-italic t)
;make the fringe stand out from the background
(setq solarized-distinct-fringe-background t)

; set thema
;;(load-theme 'solarized-dark t)
(load-theme 'afternoon t)
; set bottom line 
(require 'powerline)
(powerline-default-theme)

; enable line numeration
(global-linum-mode t)

; enable column numeration.
(column-number-mode t)

; set up visible tabs
(require 'centaur-tabs)
(centaur-tabs-mode t)
(global-set-key (kbd "C-c <left>")  'centaur-tabs-backward)
(global-set-key (kbd "C-c <right>") 'centaur-tabs-forward)
; bar in the same color
(centaur-tabs-headline-match)
; bar style
(setq centaur-tabs-style "bar")
; enable icons
(setq centaur-tabs-set-icons t)
; enable active tab marker
(setq centaur-tabs-set-bar 'left)

; config side nav
(add-to-list 'load-path "/home/taba1uga/Desktop/")
(require 'nav)
(nav-disable-overeager-window-splitting)
(global-set-key (kbd "<f8>") 'nav-toggle)
; lynx-like motion
(defun nav-mode-hl-hook ()
  (local-set-key (kbd "<right>") 'nav-open-file-under-cursor)
  (local-set-key (kbd "<left>")  'nav-go-up-one-dir))
(add-hook 'nav-mode-hook 'nav-mode-hl-hook)

; add powerline colors
(require 'flycheck-color-mode-line)
(eval-after-load "flycheck"
  '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))

;default font
(set-frame-font "Futura 20")


;; Global config

;; ;enable auto-completion
;; (require 'auto-complete)
;; ;do default config
;; (require 'auto-complete-config)
;; (ac-config-default)

; enable auto paranthesis completion
(electric-pair-mode 1)

; enable company auto-completion
(use-package company
	:ensure t
	:config
	(setq company-tooltip-limit 20)
	(setq company-show-numbers t)
	(setq company-idle-delay 0)
	(setq company-echo-delay 0)
	(setq company-minimum-prefix-length 1)
	(setq company-selection-wrap-around t)
        ; Use tab key to cycle through suggestions.
        ; ('tng' means 'tab and go')
	(company-tng-configure-default)
)

; enable company code docs
(company-quickhelp-mode t)
(setq company-quickhelp-delay 1)

; set company backend

; enable snippets completetion
(require 'yasnippet)
(yas-global-mode 1)

; enable code checking
(add-hook 'after-init-hook #'global-flycheck-mode)

; display errors in small pop-up window
;; (require 'pos-tip)
;; (eval-after-load 'flycheck
;;  (if (display-graphic-p)
;;      (flycheck-pos-tip-mode)
;;    (flycheck-popup-tip-mode)))

; display error inline
(require 'flycheck-inline)
(with-eval-after-load 'flycheck
  (add-hook 'flycheck-mode-hook #'flycheck-inline-mode))

; turn Yes or No into y or n
(defalias 'yes-or-no-p 'y-or-n-p)
    
;; Open terminal by pressing F4 key
(global-set-key [f4] '(lambda () (interactive) (term (getenv "SHELL"))))

; custom commenting
(defun toggle-comment ()
  "Toggle comments on the current line or highlighted region."
  (interactive)
  (if mark-active
      (let ((mark (mark))
            (point (point)))
        (if (> (mark) (point))
            (comment-or-uncomment-region
             point
             mark)
          (comment-or-uncomment-region
           mark
           point)))
    (comment-or-uncomment-region
     (line-beginning-position)
     (line-end-position))))
(global-set-key (kbd "<f1>") 'toggle-comment)



;; C

; enable flycheck 
(add-hook 'c-mode-hook 'flycheck-mode)

;; ; enable c headers auto-completion
;; (defun my:ac-c-header-init ()
;; 	(require 'auto-complete-c-headers)
;; 	(add-to-list 'ac-sources 'ac-source-c-headers)
;; 	; add headers locations
;; 	(add-to-list 'achead:include-directories '"/Library/Developer/CommandLineTools/usr/lib/clang/13.0.0/include")
;; 	(add-to-list 'achead:include-directories '"/Library/Developer/CommandLineTools/SDKs/MacOSX12.1.sdk/usr/include")
;; 	(add-to-list 'achead:include-directories '"/Library/Developer/CommandLineTools/usr/include")
;; 	(add-to-list 'achead:include-directories '"/Library/Developer/CommandLineTools/SDKs/MacOSX12.1.sdk/System/Library/Frameworks")
;; )
;; ; assign to hooks
;; (add-hook 'c-mode-hook 'my:ac-c-header-init)

; enable always code formatting
(add-hook 'c-mode-hook 'google-set-c-style)
; enable audo indent on new line
(add-hook 'c-mode-hook 'google-make-newline-indent)


; static code analysis
(with-eval-after-load 'flycheck
  (require 'flycheck-clang-analyzer)
  (flycheck-clang-analyzer-setup))

; compilation shortcut
(global-set-key (kbd "<f2>") 'compile)

; use gcc with c17 standard
(add-hook 'c-mode-hook
  (lambda ()
    (unless (file-exists-p "Makefile")
      (set (make-local-variable 'compile-command)
       (let ((file (file-name-nondirectory buffer-file-name)))
         (concat "gcc -std=c17 -o " 
             (concat (file-name-sans-extension file) ".out")
             " " file))))))

; create formatting standard file
(defun create-clang-format ()
  (when (eq major-mode 'c-mode)
  (interactive)
  (shell-command "clang-format -style=llvm -dump-config > .clang-format"))
)
; enable code auto-formatting
(add-hook 'before-save-hook #'create-clang-format)
; reformat buffer if .clang-format exists in the projectile root
(add-hook 'c-mode-hook
          (function (lambda ()
                    (add-hook 'before-save-hook
                              'clang-format-buffer))))
  

; show function arguments in mini-buffer
(require 'irony-eldoc)
(add-hook 'irony-mode-hook #'irony-eldoc)

; add company backend
(use-package company-irony
	:ensure t
	:config
	(require 'company)
	(add-to-list 'company-backends 'company-irony)
)

(require 'company)
(with-eval-after-load 'company
	(add-hook 'c-mode-hook 'company-mode)
	(add-hook 'c-mode-hook 'irony-mode)
	(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

)

; company headers completion
(require 'company-irony-c-headers)
   ;; Load with `irony-mode` as a grouped backend
   (eval-after-load 'company
     '(add-to-list
       'company-backends '(company-irony-c-headers company-irony)))

; enable semantic for code parsing and autocompletion
(semantic-mode 1)
; add c directories
(defun my-semantic-hook ()
  ;; these are buffer-local
  (mapc (lambda (dir)
          (semantic-add-system-include dir 'c-mode))
        '("/Library/Developer/CommandLineTools/usr/lib/clang/13.0.0/include" 
	  "/Library/Developer/CommandLineTools/SDKs/MacOSX12.1.sdk/usr/include"
	  "/Library/Developer/CommandLineTools/usr/include"
	  "/Library/Developer/CommandLineTools/SDKs/MacOSX12.1.sdk/System/Library/Frameworks")
	)
)

(add-hook 'semantic-mode-hook 'my-semantic-hook)
(add-hook 'c-mode-hook 'my-semantic-hook)


;; python

; set up elpy
(setq elpy-rpc-virtualenv-path 'current)
(elpy-enable)

;; set up Flymake
(add-hook 'after-init-hook 'flymake-start-on-save-buffer)
;; configure flymake for Python
(when (load "flymake" t)
  (defun flymake-pylint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "epylint" (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pylint-init)))
(add-hook 'python-mode-hook '(lambda () (flymake-mode)))
(define-key flymake-mode-map (kbd "M-n") 'flymake-goto-next-error)
(define-key flymake-mode-map (kbd "M-p") 'flymake-goto-prev-error)

;; set up FlyCheck
(require 'flycheck-mypy)
(add-hook 'python-mode-hook 'flycheck-mode)

;; set up MyPy
(flycheck-define-checker
    python-mypy ""
    :command ("mypy"
              "--ignore-missing-imports"
              "--python-version" "3.6"
              source-original)
    :error-patterns
    ((error line-start (file-name) ":" line ": error:" (message) line-end))
    :modes python-mode)
(add-to-list 'flycheck-checkers 'python-mypy t)
(flycheck-add-next-checker 'python-pylint 'python-mypy t)

; set up virtualenv paths
(setenv "WORKON_HOME" "~/.virtualenv")

; disable wierd indentation
(electric-indent-mode -1)

(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i --simple-prompt")

; autoformatting for python
(add-hook 'python-mode-hook 'python-black-on-save-mode)

; autocompletion for python
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

; use python3
(setq elpy-rpc-python-command "python3")

; use ipython3
(setenv "IPY_TEST_SIMPLE_PROMPT" "1")
(setq python-shell-interpreter "ipython3"
      python-shell-interpreter-args "-i")



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(package-selected-packages
   '(irony yasnippet-snippets use-package solarized-theme python-black py-autopep8 nav jedi-direx google-c-style flycheck-pos-tip flycheck-popup-tip flycheck-mypy flycheck-clang-analyzer exec-path-from-shell elpy clang-format centaur-tabs auto-complete-c-headers)))
