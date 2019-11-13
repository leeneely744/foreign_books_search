import React from 'react';

export default function Detail(props) {
  const book = props.book

  const getBookUrl = (theBook) => {
    if (theBook.affiliateUrl != '') {
      return `${theBook.affiliateUrl}`
    }
    return `${theBook.itemUrl}`
  }

  return (
    <div className='detail-book'>
      <h1 className='detail-book-title'>{book.title}</h1>
      <img className='detail-image' src={book.largeImageUrl} />
    </div>
  )
}