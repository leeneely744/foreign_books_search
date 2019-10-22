import axios from 'axios';

// 開発中はここを'http://localhost:3001/graphql'に合わせる
const API_ENDPOINT = 'http://localhost:3001/graphql';
const QUERY_FOR_GENGE = "query { genreGroups { id booksGenreId booksGenreName genres { booksGenreId booksGenreName }}}";

const myAxios = axios.create({
  headers: {
    'Content-Type': 'application/json'
  }
});

export const requestBooks = (params) => {
  myAxios
  .post(API_ENDPOINT, {query: params})
  .then((results) => {
    return results.data.data.books;
  },
  )
  .catch((error) => {
    console.log(error);
  });
}

export const initGenreGroupsPromise = () => {
  return  new Promise((resolve, reject) => {
    myAxios
    .post(API_ENDPOINT, {
      query: QUERY_FOR_GENGE
    })
    .then((results) => {
      resolve(results.data.data.genreGroups);
    })
    .catch((error) => {
      console.log(error);
      reject([]);
    });
  });
}