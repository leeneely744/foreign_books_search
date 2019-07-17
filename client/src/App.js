import React, { Component } from 'react';
import './App.css';
import axios from 'axios';
import { requestBooks } from './Request';
import Show from './Show';
import Button from '@material-ui/core/Button';
import TextField from '@material-ui/core/TextField';
import 'typeface-roboto';

// 開発中はここを'http://localhost:3001/graphql'に合わせる
const API_ENDPOINT = 'http://localhost:3001/graphql';
const myAxios = axios.create({
  headers: {
    'Content-Type': 'application/json'
  }
});
const QUERY_FOR_GENGE = "query { genreGroups { id booksGenreName genres { booksGenreId booksGenreName }}}";

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      books: [],
      title: '',
      pageFrom: '',
      pageTo: '',
      GenreGroups: this.initializeGenreGroups(),
    };

    this.handleChangeTitleField = this.handleChange.bind(this);
    this.handleChangePageFromField = this.handleChange.bind(this);
    this.handleChangePageToField = this.handleChange.bind(this);
  }

  initializeGenreGroups() {
    myAxios
    .post(API_ENDPOINT, {
      query: QUERY_FOR_GENGE
    })
    .then((results) => {
      return results.data.data.genreGroups;
    },
    )
    .catch((error) => {
      return [];
    });
  }

  handleGetLatAndLng() {
    requestBooks();
  }

  handleChange(event) {
    let stateName = event.target.name;
    this.setState({[stateName]: event.target.value});
  }

  updateBooks(newBooks) {
    console.log(newBooks);
    this.setState({books: newBooks});
  }
  
  render() {
    return (
      <div className="App">
        <div className="App-header">
          <h2>洋書おすすめ検索</h2>
        </div>

        <form onSubmit={this.handleGetLatAndLng}>
          <TextField
            id='title'
            name='title'
            label='タイトル'
            // onChange={this.handleChangeTitleField}
            onChange={this.handleChangeTitleField}
            inputProps={{ maxLength: 20 }}
          />
          <TextField
            id='page-from'
            name='pageFrom'
            label='最小ページ数'
            type='number'
            onChange={this.handleChangePageFromField}
          />
          <TextField
            id='page-to'
            name='pageTo'
            label='最大ページ数'
            type='number'
            onChange={this.handleChangePageToField}
          />
        </form>

        <div className='Search'>
          <Button
            variant='contained'
            color='primary'
            size='large'
            onClick={() => this.handleGetLatAndLng()}
          >
            検索
          </Button>
        </div>
        <Show 
          books={this.state.books}
        />
      </div>
    );
  }
}

export default App;
