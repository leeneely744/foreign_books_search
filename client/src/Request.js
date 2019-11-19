import axios from 'axios';
import config from './env.js';

// client/src/env.js を読み込む
const API_ENDPOINT = config.API_URL;
const QUERY_FOR_GENGE = "query { genreGroups { id booksGenreId booksGenreName genres { booksGenreId booksGenreName }}}";

const myAxios = axios.create({
  headers: {
    'Content-Type': 'application/json'
  }
});

/**
 * book fieldsにリクエストを行う
 * @param {'query'キーの値として設定する文字列} params
 */
export const requestBookPromise = (params) => {
  return new Promise((resolve, reject) => {
    myAxios
    .post(API_ENDPOINT, {query: params})
    .then((results) => {
      if (results.data.errors) {
        console.log(results.data.errors)
      } else {
        resolve(results.data.data.book);
      }
    },
    )
    .catch((error) => {
      console.log(error);
      reject(error)
    });
  })
}

/**
 * books fieldsにリクエストを行う。
 * @param {'query'キーの値として設定する文字列} params 
 */
export const requestBooksPromise = (params) => {
  return new Promise((resolve, reject) => {
    myAxios
    .post(API_ENDPOINT, {query: params})
    .then((results) => {
      if (results.data.errors) {
        console.log(results.data.errors)
      } else {
        resolve(results.data.data.books);
      }
    },
    )
    .catch((error) => {
      console.log(error);
      reject(error)
    });
  })
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