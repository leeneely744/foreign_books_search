import React, { Component } from 'react';
import './App.css';
import { requestBooks, initGenreGroupsPromise } from './Request';
import Show from './Show';
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
      checkedGenres: [],
      usedGenres: false,
    };

    initGenreGroupsPromise()
      .then((result) => {
        const genreGroups = Object.values(result);
        this.setState({
          genreGroups: genreGroups,
          checkedGenres: initCheckedGenres(genreGroups),
        });
      })
      .catch((error) => {
        console.log("error occured = " + error);
      });

    this.handleChangeTitleField = this.handleChange.bind(this);
    this.handleChangePageFromField = this.handleChange.bind(this);
    this.handleChangePageToField = this.handleChange.bind(this);
    this.handleChangeToggleGenre = this.handleChangeToggle.bind(this);
    this.handleCheckGenre = this.handleCheck.bind(this);
  }

  static getDerivedStateFromError(error) {
    // Update state so the next render will show the fallback UI.
    return { hasError: true };
  }

  // componentDidCatch(error, info) {
  //   // You can also log the error to an error reporting service
  //   logErrorToMyService(error, info);
  // }

  handleGetLatAndLng() {
    requestBooks();
  }

  handleChange(event) {
    let stateName = event.target.name;
    this.setState({[stateName]: event.target.value});
  }

  handleChangeToggle(event) {
    let nowState = this.state.usedGenres;
    this.setState({usedGenres: !nowState});
  }

  handleCheck(booksGenreId, isChecked) {
    const checkboxs = this.state.checkedGenres.slice();
    checkboxs[booksGenreId] = isChecked;
    this.setState({checkedGenres: checkboxs});
  }

  updateBooks(newBooks) {
    console.log(newBooks);
    this.setState({books: newBooks});
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
              checkState={this.state.checkedGenres}
              onClick={this.handleCheckGenre}
            />
          </Collapse>
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

function initCheckedGenres(genreGroups) {
  let checkboxs = [];
  genreGroups.forEach(genreGroup => {
    genreGroup['genres'].forEach(genre => {
      checkboxs[genre.booksGenreId] = false;
    });
  });
  return checkboxs;
}

export default App;
