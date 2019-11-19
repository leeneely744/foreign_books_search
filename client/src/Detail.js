import React from 'react';
import { makeStyles, Button } from '@material-ui/core';

const useStyles = makeStyles(theme => ({
  button: {
    margin: theme.spacing(1),
  },
}))

export default function Detail(props) {
  const book = props.book
  const classes = useStyles()

  const getBookUrl = (theBook) => {
    if (theBook.affiliateUrl !== '') {
      return `${theBook.affiliateUrl}`
    }
    return `${theBook.itemUrl}`
  }

  const getGenreName = (theBook) => {
    if (theBook.genre === undefined) {
      return '不明'
    }
    return theBook.genre.booksGenreName
  }

  return (
    <div id='detail-book'>
      <div id='detail-book-title'>{book.title}</div>
      <div id='detail-author'>著者名：{book.author}</div>
      <img id='detail-image' alt={book.title} src={book.largeImageUrl} />
      <div id='detail-updated-at'>書籍情報更新日:{book.updatedAt}</div>
      <table id='detail-table'>
        <tbody>
          <tr id='detail-genre'>
            <td id='detail-genre-head' className='detail-table-head'>ジャンル：</td>
            <td id='detail-genre-value' className='detail-table-value'>{getGenreName(book)}</td>
          </tr>
          <tr id='detail-page'>
            <td id='detail-page-head' className='detail-table-head'>ページ数：</td>
            <td id='detail-page-value' className='detail-table-value'>{book.page}</td>
          </tr>
          <tr id='detail-review-average'>
            <td id='detail-review-average-head' className='detail-table-head'>レビュー平均：</td>
            <td id='detail-review-average-value' className='detail-table-value'>{book.reviewAverage}</td>
          </tr>
          <tr id='detail-review-count'>
            <td id='detail-review-count-head' className='detail-table-head'>レビュー数：</td>
            <td id='detail-review-count-value' className='detail-table-value'>{book.reviewCount}</td>
          </tr>
        </tbody>
      </table>
      <div id='detail-item-caption'>{book.itemCaption}</div>
      <Button variant="contained" href={getBookUrl(book)} color="primary" id='rakuten-button' className={classes.button} >
        楽天で見る
      </Button>
    </div>
  )
}