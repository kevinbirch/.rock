(setq header-license
      "Distributed under an [MIT-style][license] license.

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files \(the \"Software\"), to deal with
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

- Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimers.
- Redistributions in binary form must reproduce the above copyright notice, this
  list of conditions and the following disclaimers in the documentation and/or
  other materials provided with the distribution.
- Neither the names of the copyright holders, nor the names of the authors, nor
  the names of other contributors may be used to endorse or promote products
  derived from this Software without specific prior written permission.

THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE CONTRIBUTORS
OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS WITH THE SOFTWARE.

\[license]: http://www.opensource.org/licenses/ncsa")

(defun header-license ()
  "Insert license"
  (header-block header-license)
)

(defun header-block (text-block)
  "Insert a block of multiline header text"
  (beginning-of-line)
  (mapcar (lambda (each)
            (insert header-prefix-string each "\n")
            )
          (split-string text-block "\n")))

(defun header-begin ()
  "Open the header comment block"
  (insert comment-start "\n"))

(defun header-end ()
  "Close teh header comment block"
  (insert comment-end "\n"))

(setq header-copyright-notice (format-time-string "Copyright (c) %Y Kevin Birch <kmb@pobox.com>.  All rights reserved.\n"))

(setq make-header-hook '(header-begin
                         header-copyright
                         header-blank
                         header-license
                         header-end
                         ))
