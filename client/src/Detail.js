import React from 'react';

export default function Detail(props) {
  const book = props.book

  const getBookUrl = (theBook) => {
    if (theBook.affiliateUrl !== '') {
      return `${theBook.affiliateUrl}`
    }
    return `${theBook.itemUrl}`
  }

  return (
    <div id='detail-book'>
      <h1 id='detail-book-title'>{book.title}</h1>
      <div id='detail-author'>著者名：{book.author}</div>
      <img id='detail-image' alt={book.title} src={book.largeImageUrl} />
      <div id='detail-item-caption'>{book.itemCaption}</div>
      <div id='detail-updated-at'>書籍情報更新日:{book.updatedAt}</div>
      <table id='detail-table'>
        <tbody>
          <tr id='detail-genre'>
            <td id='detail-genre-head'>ジャンル：</td>
            <td id='detail-genre-value'>test</td>
          </tr>
          <tr id='detail-page'>
            <td id='detail-page-head'>ページ数：</td>
            <td id='detail-page-value'>{book.page}</td>
          </tr>
          <tr id='detail-review-average'>
            <td id='detail-review-average-head'>レビュー平均：</td>
            <td id='detail-review-average-value'>{book.reviewAverage}</td>
          </tr>
          <tr id='detail-review-count'>
            <td id='detail-review-count-head'>レビュー数：</td>
            <td id='detail-review-count-value'>{book.reviewCount}</td>
          </tr>
        </tbody>
      </table>
    </div>
  )
}