(defadvice Man-quit(after maybe-close-frame activate)
  "`delete-frame-on-man-quit' is defined by an external script which
   launches an emacs frame for a specific man page. After being launched,
   this allows the `Man-quit' function to close the frame."
  (if delete-frame-on-man-quit
      (delete-frame)))
