import React, { Component } from 'react';
import './css/App.css';
import { requestBooksPromise, requestBookPromise, initGenreGroupsPromise } from './Request';
import { booksQuery, bookQuery } from './QueryBuilder';
import Show from './Show';
import Detail from './Detail';
import GenreGroupForm from './form/GenreGroupsForm';
import Button from '@material-ui/core/Button';
import TextField from '@material-ui/core/TextField';
import FormControlLabel from '@material-ui/core/FormControlLabel';
import 'typeface-roboto';
import { Switch, Collapse } from '@material-ui/core';

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      hasError: false,
      books: [],
      title: '',
      pageFrom: '',
      pageTo: '',
      genreGroups: [],
      usedGenres: false,
      showDetailPageFlg: false,
      showPageSet: {
        totalBooksNum: 0,
      },
      book: [],
    };

    initGenreGroupsPromise()
      .then((result) => {
        this.setState({genreGroups: addCheckedField(Object.values(result))});
      })
      .then(() => this.handleSearchBooks())
      .catch((error) => {
        console.log("error occured = " + error);
      });

    this.handleChangeTitleField = this.handleChange.bind(this);
    this.handleChangePageFromField = this.handleChange.bind(this);
    this.handleChangePageToField = this.handleChange.bind(this);
    this.handleChangeToggleGenre = this.handleChangeToggle.bind(this);
    this.handleCheckGenre = this.handleCheck.bind(this);
    this.updateShowDetailPageFlg = this.updateShowDetailPageFlg.bind(this);
    this.handleClickBookLink = this.handleClickBookLink.bind(this);
  }

  static getDerivedStateFromError(error) {
    // Update state so the next render will show the fallback UI.
    return { hasError: true };
  }

  // チェックされているGenreのbooksGenreIdを配列で返す
  getCheckedGenreIds(genreGroups) {
    let allGenreGroups = genreGroups.map(genreGroup => genreGroup['genres'])
    let allTrueGenres = [];
    allGenreGroups.forEach((genreGroup) => {
      genreGroup.forEach((genre) => {
        if (genre.isChecked === true) {
          allTrueGenres.push(genre.booksGenreId);
        }
      })
    })
    return allTrueGenres;
  }

  // ["value1", "value2"]という形の文字列にする必要がある。
  getCheckedGenreIdsForQuery(genreGroups, isUseGenres) {
    let allTrueGenres = this.getCheckedGenreIds(genreGroups);
    if (isUseGenres === false || allTrueGenres === []) {
      return "[]";
    }
    let tmpStr = allTrueGenres.toString().replace(/,/g, '","');
    return `["${tmpStr}"]`;
  }

  getPageNum(pageNum, defaultValue = 0) {
    if (pageNum === null || pageNum === '') {
      return defaultValue;
    } else {
      return parseInt(pageNum, 10)
    }
  }

  getTitle(title) {
    return title === '' ? `""` : title
  }

  handleSearchBooks() {
    this.updateShowDetailPageFlg(false);
    let checkedGenreId = this.getCheckedGenreIdsForQuery(this.state.genreGroups, this.state.usedGenres);
    const requestParams = booksQuery({
      fields: [
        'title'
        , 'booksGenreId'
        , 'mediumImageUrl'
        , 'largeImageUrl'
        , 'reviewCount'
        , 'reviewAverage'
        , 'vocabulary'
        , 'page'
        , 'id'
      ],
      variables: {
        title: this.getTitle(this.state.title),
        booksGenreId: checkedGenreId,
        pageNumFrom: this.getPageNum(this.state.pageFrom, 0),
        pageNumTo: this.getPageNum(this.state.pageTo, 9999)
      }
    })
    requestBooksPromise(requestParams)
      .then((result) => {
        this.updateBooks(result);
        let newState = this.state.showPageSet
        newState['totalBooksNum'] = Object.keys(result).length
        this.setState({showPageSet: newState})
      })
  }

  handleChange(event) {
    let stateName = event.target.name;
    this.setState({[stateName]: event.target.value});
  }

  handleChangeToggle(event) {
    let nowState = this.state.usedGenres;
    this.setState({usedGenres: !nowState});
  }

  handleCheck(clickedBooksGenreId, isChecked) {
    let newGenreGroups = this.state.genreGroups
    newGenreGroups.forEach(genreGroup => {
      if (genreGroup['booksGenreId'].startsWith(clickedBooksGenreId)) {
        genreGroup['isChecked'] = !isChecked;
      }
      genreGroup['genres'].forEach(genre => {
        if (genre['booksGenreId'].startsWith(clickedBooksGenreId)) {
          genre['isChecked'] = !isChecked;
        }
      });
    });
    this.setState({ genreGroups: newGenreGroups });
  }

  updateBooks(newBooks) {
    this.setState({books: newBooks});
  }

  updateBook(newBook) {
    this.setState({book: newBook});
  }

  handleClickBookLink(booksGenreId) {
    this.searchBookDetail(booksGenreId);
    this.updateShowDetailPageFlg(true);
  }

  getBooksGenreId(searchValue) {
    return `"${searchValue}"`;
  }

  searchBookDetail(id) {
    const requestParams = bookQuery({
      fields: [
        'title', 'largeImageUrl', 'reviewCount', 'reviewAverage', 'vocabulary'
        , 'page', 'author', 'publisherName', 'itemCaption'
        , 'itemUrl', 'affiliateUrl', 'updatedAt'
        , 'genre { booksGenreName }'
      ],
      variables: {
        id: id
      }
    })
    requestBookPromise(requestParams)
      .then((result) => {
        this.updateBook(result);
      })
  }

  updateShowDetailPageFlg(showDetailPage = true) {
    this.setState({showDetailPageFlg: showDetailPage});
  }
  
  render() {
    if (this.state.hasError) {
      // You can render any custom fallback UI
      return <h1>Something went wrong.</h1>;
    }

    return (
      <div className="App">
        <div className="App-header">
          <h2>洋書おすすめ検索</h2>
        </div>

        <form onSubmit={this.handleSearchBooks} className={"books-search-form"}>
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

          <FormControlLabel
            control={
              <Switch
                checked={this.state.usedGenres}
                onChange={this.handleChangeToggleGenre}
                color="secondary"
              />
            }
            label="ジャンルを使用する"
          />
          <Collapse in={this.state.usedGenres}>
            <GenreGroupForm
              genreGroups={this.state.genreGroups}
              onClick={this.handleCheckGenre}
            />
          </Collapse>
          <Button
            variant='contained'
            color='primary'
            size='large'
            onClick={() => this.handleSearchBooks()}
          >
            検索
          </Button>
        </form>
        
        <div className='right-panel'>
          { this.state.showDetailPageFlg ?
            <Detail book={this.state.book} /> :
            <Show 
              books={this.state.books}
              onClickBookLink={this.handleClickBookLink}
              showPageSet={this.state.showPageSet}
            />
          }
        </div>
      </div>
    );
  }
}

function addCheckedField(genreGroups) {
  genreGroups.forEach(genreGroup => {
    genreGroup['isChecked'] = false
    genreGroup['genres'].forEach(genre => {
      genre['isChecked'] = false;
    });
  });
  return genreGroups;
}

export default App;
