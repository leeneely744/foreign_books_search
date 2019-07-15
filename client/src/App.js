import React, { Component } from 'react';
import './App.css';
import axios from 'axios';
import Show from './Show';

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
          <h2>洋書おすすめ検索</h2>
        </div>
        <div className='Search'>
          <input
           type='button'
           value='検索'
           onClick={() => this.handleGetLatAndLng()}
          />
        </div>
        <Show 
          books={this.state.books}
        />
      </div>
    );
  }
}

export default App;
