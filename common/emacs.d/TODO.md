## TODO

* (setq ns-use-srgb-colorspace t)
* make a project for ido-goto
  * https://gist.github.com/kevinbirch/8344414
  * https://github.com/cask/cask
  *  http://tuxicity.se/emacs/cask/ert/ert-runner/ert-async/ecukes/testing/travis/2014/01/09/various-testing-tools-in-emacs.html
  * add to: http://www.emacswiki.org/emacs/InteractivelyDoThings
  * add to: http://www.emacswiki.org/emacs/ImenuMode#toc11
  * function list as a popup/overlay?
* force rope to put project file in git sandbox root always
* https://github.com/tkf/emacs-jedi ?
* ctrl-tab to switch buffer (with popup?)
  * http://www.emacswiki.org/emacs/ControlTABbufferCycling
* fix bugs in moveline function
* make sure duplicate above and below works
* use tab to cycle completions in ido menu, another key to show list in another buffer
* jump cursor to list buffer when it is shown
* move to other window by arrow key
* add smex http://www.emacswiki.org/emacs/Smex
* bind comment-dwim
* persistent scratch buffer
* persistent minibuffer
  * http://www.reddit.com/r/emacs/comments/1umzxo/full_persistent_minibuffer_history_it_was_built/
* back/forward navigation
  * https://github.com/gigamonkey/jumper
* next-error should jump to fly{check,make} errors as well
* replace flymake with flycheck
* c-mode
  * fix style
  * compare style w/ google style
  * http://www.emacswiki.org/emacs/IndentingC
  * http://www.gnu.org/software/emacs/manual/html_node/ccmode/Custom-Braces.html#Custom-Braces
  * http://www.gnu.org/software/emacs/manual/html_node/emacs/Programs.html#Programs
  * http://www.gnu.org/software/emacs/manual/html_node/emacs/C-Modes.html#C-Modes
  * electric layout mode, etc
    * http://www.gnu.org/software/emacs/manual/html_node/emacs/Misc-for-Programs.html#Misc-for-Programs
* c navigation
  * https://github.com/Andersbakken/rtags
    * rtags server inferior process
    * http://www.gnu.org/software/emacs/manual/html_node/elisp/Processes.html
    * http://www.splode.com/users/friedman/software/emacs-lisp/index.html#processes
    * structural search/replace, refactor?
  * http://www.emacswiki.org/emacs/EmacsTags
  * https://github.com/dkogan/xcscope.el
  * cedet
    * http://alexott.net/en/writings/emacs-devenv/EmacsCedet.html
    * http://www.emacswiki.org/emacs/CollectionOfEmacsDevelopmentEnvironmentTools#CEDET
  * https://github.com/sabof/project-explorer
* automatically fold copyright headers
  * http://www.splode.com/users/friedman/software/emacs-lisp/src/kill-a-lawyer.el
  * ~/Downloads/hide-copyleft.el
* use autoload more to selectively load mode-specific features? (in non-gui mode?)
* read more about narrowing
  * http://www.gnu.org/software/emacs/manual/html_node/emacs/Narrowing.html#Narrowing
* move functions up and down, respecting spacing between them
  * http://www.emacswiki.org/emacs/CcMode (ref my-move-function-{up,down})
* per-project settings
  * c style
  * copyright headers
  * http://www.emacswiki.org/emacs/ProjectSettings
  * http://www.emacswiki.org/emacs/DirectoryVariables
* emacs rocks: http://emacsrocks.com
  * hightlight multiple
* configure shell mode
  * http://www.reddit.com/r/emacs/comments/1udofn/which_shell_mode_do_you_use/
* helper to synchronize packages
  * http://www.reddit.com/r/emacs/comments/1u0xr4/quick_hack_syncing_required_packages_in_emacs/
* better cclookup mode
  * https://github.com/tsgates/cclookup
  * look up for c
  * reindex
  * all in elisp
* mail in emacs
  * wanderlust?
  * mu4e?
  * http://www.emacswiki.org/emacs/CategoryMail
  * http://www.splode.com/users/friedman/software/emacs-lisp/index.html#mail
* http://www.splode.com/users/friedman/software/emacs-lisp/src/buffer-fns.el
* improved buffer list mode
  * http://www.splode.com/users/friedman/software/emacs-lisp/src/listbuf.el
* icicles?
  * http://www.emacswiki.org/emacs/Icicles_-_Ido_and_IswitchB
* drew adams' packages:
  * http://www.emacswiki.org/emacs/DrewAdams
* can customize variables be set with some command other than setq?
  * http://www.emacswiki.org/emacs/cus-edit+.el
* fuzzy selection narrowing for auto-complete popup?
* sentry client? http://sentry.readthedocs.org/en/latest/developer/client/index.html
