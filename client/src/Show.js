import React from 'react';
import { For } from 'react-loops'
import Card from '@material-ui/core/Card'
import CardMedia from '@material-ui/core/CardMedia'
import { makeStyles } from '@material-ui/styles';

export default function Show(props) {
  let books = Object.values(props.books)
  return (
    <For of={books} ifEmpty={<h1>書籍がありません。</h1>}>
      {book =>
        <button onClick={() => props.onClickBookLink(true)}>
          <Book books={book} />
        </button>
      }
    </For>
  );
}

const useStyles = makeStyles(theme => ({
  card: {
    maxWidth: 345,
  },
  media: {
    height: 0,
    paddingTop: '56.25%',
  },
}))

function Book(props) {
  const classes = useStyles()
  return (
    <Card className={classes.card}>
      <CardMedia
        className={classes.media}
        children={<BookImage title={props.title} imageUrl={props.largeImageUrl}/>}
        title={props.title}
      />
    </Card>
  )
}

function BookImage(props) {
  return (
    <img src={props.imageUrl} alt={props.title} />
  )
}