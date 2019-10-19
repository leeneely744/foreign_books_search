import React, { Component } from 'react';
import './css/App.css';
import { queryBuilder, requestBooks, initGenreGroupsPromise } from './Request';
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
      usedGenres: false,
    };

    initGenreGroupsPromise()
      .then((result) => {
        this.setState({genreGroups: addCheckedField(Object.values(result))});
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

        <form onSubmit={this.handleGetLatAndLng} className={"books-search-form"}>
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
            onClick={() => this.handleGetLatAndLng()}
          >
            検索
          </Button>
        </form>
        
        <Show 
          books={this.state.books}
        />
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
