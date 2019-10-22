import React from 'react';

export default function Show(props) {
  const booksNum = Object.keys(props.books).length;
  if (booksNum === 0) {
    return <NoBooks/>
  } else {
    return (
      <div style={{whiteSpace: 'pre-line'}}>
        <ul>{this.props.books}</ul>
      </div>
    );
  }
}

function NoBooks(props) {
  return <h1>書籍がありません。</h1>
}