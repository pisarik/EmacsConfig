;; adding MELPA Stable to package repos
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))

(setq package-archive-priorities
      '(("melpa-stable" . 10)
        ("gnu"          . 5)
        ("melpa"        . 0)))
(package-initialize)


;; BASIC CUSTOMIZATION
;; --------------------------------------

(setq inhibit-startup-message t)   ;; hide the startup message
(require 'material-theme)
(load-theme 'material t)           ;; load material theme
;; (global-linum-mode t)              ;; enable line numbers globally
;; (setq linum-format "%4d \u2502 ")  ;; format line number spacing

;; org-mode initialization
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;; miscellaneous

;; auto pdf updating after changed on disk
(add-hook 'doc-view-mode-hook 'auto-revert-mode)

(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a24c5b3c12d147da6cef80938dca1223b7c7f70f2f382b26308eba014dc4833a" "bfdcbf0d33f3376a956707e746d10f3ef2d8d9caa1c214361c9c08f00a1c8409" default)))
 '(package-selected-packages
   (quote
    (magit auctex pyenv-mode py-autopep8 multiple-cursors material-theme flycheck expand-region ess elpy ein company-irony better-defaults avy))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; start yasnippet
(require 'yasnippet)
(yas-global-mode 1)

;; == irony-mode ==
;; (use-package irony
;; 	     :ensure t
;; 	     :defer t
;; 	     :init
;; 	     (add-hook 'c++-mode-hook 'irony-mode)
;; 	     (add-hook 'c-mode-hook 'irony-mode)
;; 	     (add-hook 'objc-mode-hook 'irony-mode)
;; 	     :config
;; 	     ;; replace the `completion-at-point' and `complete-symbol' bindings in
;; 	     ;; irony-mode's buffers by irony-mode's function
;; 	     (defun my-irony-mode-hook ()
;; 	       (define-key irony-mode-map [remap completion-at-point]
;; 		 'irony-completion-at-point-async)
;; 	       (define-key irony-mode-map [remap complete-symbol]
;; 		 'irony-completion-at-point-async))
;; 	     (add-hook 'irony-mode-hook 'my-irony-mode-hook)
;; 	     (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
;; 	     )

;; ;; == company-mode ==
;; (use-package company
;; 	     :ensure t
;; 	     :defer t
;; 	     :init (add-hook 'after-init-hook 'global-company-mode)
;; 	     :config
;; 	     (use-package company-irony :ensure t :defer t)
;; 	     (setq company-idle-delay              nil
;; 		   company-minimum-prefix-length   2
;; 		   company-show-numbers            t
;; 		   company-tooltip-limit           20
;; 		   company-dabbrev-downcase        nil
;; 		   company-backends                '((company-irony company-gtags))
;; 		   )
;; 	     :bind ("C-;" . company-complete-common)
;; 	     )

(require 'irony)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

(require 'company-irony)
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

(avy-setup-default)
(global-set-key (kbd "C-c C-j") 'avy-resume)
(global-set-key (kbd "C-c SPC") 'avy-goto-word-1)

;; PYTHON CONFIGURATION
;; ------------------------------------------------

(load "~/.emacs.d/python.el")
(load "~/.emacs.d/utils.el")
;; (elpy-enable)

;; ;; use flycheck not flymake with elpy
;; (when (require 'flycheck nil t)
;;   (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
;;   (add-hook 'elpy-mode-hook 'flycheck-mode))

;; (setq elpy-rpc-backend "rope")

;; (require 'company-jedi)
;; (setq jedi:complete-on-dot t)
;; (eval-after-load 'company
;;   '(add-to-list 'company-backends 'company-jedi))

;; (add-hook 'python-mode-hook 'company-mode)

;;(require 'ess)
