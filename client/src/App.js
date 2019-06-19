import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';
import axios from 'axios';

// https://qiita.com/api/v2/docs#%E3%82%BF%E3%82%B0
const API_ENDPOINT = 'https://qiita.com/api/v2/tags';

class App extends Component {
  handleGetLatAndLng() {
    axios
      .get(API_ENDPOINT)
      .then((results) => {
        const datas = results.data;
        console.log(datas);
      },
      )
      .catch((error) => {
        console.log(error);
      });
  }

  render() {
    return (
      <div className="App">
        <div className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <h2>Welcome to React</h2>
        </div>
        <div className="App-intro">
          <h1 className="app-title">QiitaタグAPIテスト</h1>
          <input
          type="button"
          value="タグ一覧を作成日時の降順でコンソールに表示します"
          onClick={() => this.handleGetLatAndLng()}
        />
        </div>
      </div>
    );
  }
}

export default App;
