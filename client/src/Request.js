import axios from 'axios';

// 開発中はここを'http://localhost:3001/graphql'に合わせる
const API_ENDPOINT = 'http://localhost:3001/graphql';
const QUERY_FOR_GENGE = "query { genreGroups { id booksGenreName genres { booksGenreId booksGenreName }}}";

const myAxios = axios.create({
  headers: {
    'Content-Type': 'application/json'
  }
});

export const requestBooks = () => {
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

export const initializeGenreGroups = () => {
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