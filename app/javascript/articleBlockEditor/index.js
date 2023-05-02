import React from 'react'
import { render } from 'react-dom'
import Editor from './editor'

(function ($, undefined) {
  $.fn.articleBlockEditor = function () {
    this.each((i, elm) => {
      const editorBody = elm.querySelector('.editor-body')
      const textarea = elm.querySelector('textarea')

      const onChange = value => {
        textarea.value = value
      }

      render(
        <Editor
          value={textarea.value}
          onChange={onChange}
        />,
        editorBody
      )
    })
  }
})(jQuery)
