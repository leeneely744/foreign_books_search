import React, { Component } from 'react';
import axios from 'axios';

// https://qiita.com/api/v2/docs#%E3%82%BF%E3%82%B0
const API_ENDPOINT = 'https://qiita.com/api/v2/tags';

class Search extends Component {
  constructor(props) {
    super(props);
    this.state = {
      title: null
      ,pageFrom: 0
    };
  }

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
      <div className='Search'>
        <input type='text' />
        <input
         type='button'
         value='検索'
         onClick={() => this.handleGetLatAndLng()}
        />
      </div>
    );
  }
}

export default Search;