(use-modules (gnu) (gnu system nss))
(use-service-modules desktop)
(use-package-modules certs
		     version-control
		     fonts
		     ssh
		     video
		     xorg
		     mail
		     lisp
		     curl
                     xdisorg
		     aspell
		     zip
		     wget
		     emacs
		     conkeror
		     tmux
		     shells)
(operating-system
 (host-name "room101")
 (timezone "Europe/Madrid")
 (locale "en_US.UTF-8")

 ;; Assuming /dev/sdX is the target hard disk, and "my-root"
 ;; is the label of the target root file system.
 (bootloader (grub-configuration (device "/dev/sda")))
 (file-systems (cons (file-system
		      (device "my-root")
		      (title 'label)
		      (mount-point "/")
		      (type "ext4"))
		     %base-file-systems))
 (users (cons (user-account (name "toni")
			    (comment "OHAI")
			    (group "users")
			    (supplementary-groups '("wheel" "netdev"
						    "audio" "video"))
			    (home-directory "/home/toni")
			    (shell #~(string-append #$zsh "/bin/zsh")))
	      %base-user-accounts))

 ;; This is where we specify system-wide packages.
 (packages (cons* nss-certs         ;;for HTTPS access
		  emacs
		  git
		  sbcl
		  (list sbcl-stumpwm "bin")
		  vlc
		  youtube-dl
		  wget
		  curl
		  tmux
		  conkeror
		  openssh
		  aspell
		  aspell-dict-en
		  aspell-dict-es
		  unzip
		  rxvt-unicode
		  zsh
		  xrdb
		  xbacklight
		  offlineimap
		  font-fira-mono
		  %base-packages))

 ;; Add GNOME and/or Xfce---we can choose at the log-in
 ;; screen with F1.  Use the "desktop" services, which
 ;; include the X11 log-in service, networking with Wicd,
 ;; and more.
 (services (cons* (gnome-desktop-service)
		  %desktop-services))

 ;; Allow resolution of '.local' host names with mDNS.
 (name-service-switch %mdns-host-lookup-nss))
