import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';
import axios from 'axios';
import Show from './Show';
import Button from '@material-ui/core/Button';
import 'typeface-roboto';

// 開発中はここを'http://localhost:3001/graphql'に合わせる
const API_ENDPOINT = 'http://localhost:3001/graphql';
const myAxios = axios.create({
  headers: {
    'Content-Type': 'application/json'
  }
});

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      books: [],
      searchState: [],
    };
  }

  handleGetLatAndLng() {
    myAxios
    .post(API_ENDPOINT, {
      query: "query { genreGroups{ id booksGenreName } }"
    })
    .then((results) => {
      console.log(results);
      // const datas = results.data;
      // results = datas.map(data => data.id + "\n");
      // this.updateBooks(results);
    },
    )
    .catch((error) => {
      console.log(error);
    });
  }

  updateBooks(newBooks) {
    console.log(newBooks);
    this.setState({books: newBooks});
  }
  
  render() {
    return (
      <div className="App">
        <div className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <h2>Welcome to React</h2>
        </div>
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
