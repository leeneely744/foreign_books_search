import React, { Component } from 'react';

class Show extends Component {
  render() {
    return (
      <div style={{whiteSpace: 'pre-line'}}>
        this is tag list from Qiita sorted by item count.
        <ul>{this.props.books}</ul>
      </div>
    );
  }
}

export default Show;