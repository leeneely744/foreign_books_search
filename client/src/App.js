import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';
import axios from 'axios';
import Show from './Show';

// https://qiita.com/api/v2/docs#%E3%82%BF%E3%82%B0
// このAPIは開発中に使用する仮のAPI
const API_ENDPOINT = 'https://qiita.com/api/v2/tags?sort=count';

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      books: [],
      searchState: [],
    };
  }

  handleGetLatAndLng() {
    axios
    .get(API_ENDPOINT)
    .then((results) => {
      const datas = results.data;
      results = datas.map(data => data.id + "\n");
      this.updateBooks(results);
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
