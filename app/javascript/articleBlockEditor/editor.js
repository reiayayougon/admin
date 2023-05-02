import React, { Component } from 'react'
import PropTypes from 'prop-types'
import RichTextEditor from 'react-rte'

export default class Editor extends Component {
  static propTypes = {
    value: PropTypes.string,
    onChange: PropTypes.func
  }

  constructor (props) {
    super(props)

    this.state = {
      value: RichTextEditor.createValueFromString(props.value, 'html')
    }
  }

  onChange = (value) => {
    this.setState({ value })
    if (this.props.onChange) {
      this.props.onChange(value.toString('html'))
    }
  }

  render () {
    const toolbarConfig = {
      display: [
        'INLINE_STYLE_BUTTONS',
        'BLOCK_TYPE_BUTTONS',
        'LINK_BUTTONS',
        'BLOCK_TYPE_DROPDOWN',
        'HISTORY_BUTTONS'
      ],
      INLINE_STYLE_BUTTONS: [
        {label: 'Bold', style: 'BOLD'},
        {label: 'Italic', style: 'ITALIC'},
        {label: 'Underline', style: 'UNDERLINE'}
      ],
      BLOCK_TYPE_DROPDOWN: [
        {label: 'Normal', style: 'unstyled'},
        {label: 'H1', style: 'header-one'},
        {label: 'H2', style: 'header-two'},
        {label: 'H3', style: 'header-three'}
      ],
      BLOCK_TYPE_BUTTONS: [
        {label: 'UL', style: 'unordered-list-item'},
        {label: 'OL', style: 'ordered-list-item'}
      ]
    }

    return (
      <RichTextEditor
        value={this.state.value}
        onChange={this.onChange}
        toolbarConfig={toolbarConfig}
      />
    )
  }
}
