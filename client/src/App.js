import React, { Component } from 'react';
import './App.css';
import { requestBooks, initGenreGroupsPromise } from './Request';
import Show from './Show';
import Button from '@material-ui/core/Button';
import TextField from '@material-ui/core/TextField';
import 'typeface-roboto';

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
    };

    this.handleChangeTitleField = this.handleChange.bind(this);
    this.handleChangePageFromField = this.handleChange.bind(this);
    this.handleChangePageToField = this.handleChange.bind(this);

    initGenreGroupsPromise()
      .then((result) => {
        // "result"'s type is object
        this.setState({genreGroups: result})
      })
      .catch((error) => {
        console.log("error occured");
      });
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

export default App;
