import React from 'react';
import { For } from 'react-loops'
import Card from '@material-ui/core/Card'
import CardMedia from '@material-ui/core/CardMedia'
import { makeStyles } from '@material-ui/styles';
import { CardContent, Typography } from '@material-ui/core';

export default function Show(props) {
  let books = Object.values(props.books)
  return (
    <For of={books} ifEmpty={<h1>書籍がありません。</h1>}>
      {book =>
        <button onClick={() => props.onClickBookLink(true)}>
          <Book book={book} />
        </button>
      }
    </For>
  );
}

const useStyles = makeStyles(theme => ({
  card: {
    width: 345,
    height: 351,
  },
  media: {
  },
}))

function Book(props) {
  const classes = useStyles()

  const getShowString = (data) => {
    if (data === '' || data === null) {
      return '不明'
    }
    return data
  }

  const pageString = getShowString(props.book.page)
  const vocabularyString = getShowString(props.book.vocabulary)
  const reviewAverageString = getShowString(props.book.reviewAverage)

  return (
    <Card className={classes.card}>
      <CardMedia
        className={classes.media}
        children={<BookImage title={props.book.title} imageUrl={props.book.largeImageUrl}/>}
        title={props.book.title}
      />
      <CardContent>
        <Typography variant='body1' component='p'>{props.book.title}</Typography>
        <Typography variant='body2' component='p'>{`ページ数：${pageString}`}</Typography>
        <Typography variant='body2' component='p'>{`語彙数：${vocabularyString}`}</Typography>
        <Typography variant='body2' component='p'>{`平均レビュー：${reviewAverageString}`}</Typography>
      </CardContent>
    </Card>
  )
}

function BookImage(props) {
  return (
    <img src={props.imageUrl} alt={props.title} />
  )
}