(defmethod customize-instance ((browser browser) &key)
  (setf (slot-value browser 'theme) theme:+light-theme+))
