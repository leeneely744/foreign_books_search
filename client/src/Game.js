import React from 'react';

class Game extends React.Component {
  render() {
    return (
      <div className="game">
        <div className="game-board">
          <Board />
        </div>
        <div className="game-info">
          <div>{/* status */}</div>
          <ol>{/* TODO */}</ol>
        </div>
      </div>
    );
  }
}

class Board extends React.Component {
  constructor(props) {
    super(props); // ← This is must be at the first line in the constructor.
    this.state = {
      squares: Array(9).fill(null),
      xIsNext: true,
    };
  }

  handleClick(i) {
    const squaresTmp = this.state.squares.slice();
    squaresTmp[i] = this.state.xIsNext ? 'X' : 'O';
    this.setState({
      squares: squaresTmp,
      xIsNext: !this.state.xIsNext,
    });
  }
  
  renderSquare(i) {
    return (
      <Square
        value={this.state.squares[i]}
        onClick={() => this.handleClick(i)}
      />
    );
  }

  render() {
    const status = 'Next player: ' + (this.state.xIsNext ? 'X' : 'O');

    return (
      <div>
        <div className="status">{status}</div>
        <div className="board-row">
          {this.renderSquare(0)}
          {this.renderSquare(1)}
          {this.renderSquare(2)}
        </div>
        <div className="board-row">
          {this.renderSquare(3)}
          {this.renderSquare(4)}
          {this.renderSquare(5)}
        </div>
        <div className="board-row">
          {this.renderSquare(6)}
          {this.renderSquare(7)}
          {this.renderSquare(8)}
        </div>
      </div>
    );
  }
}

/**
 * The Square component is written as a function component.
 * Function components are a simpler way to write components that 
 * only contain a render method and don't have their own state.
 * @param {display value} props 
 */
function Square(props) {
  return (
    <button className="square" onClick={props.onClick} >
      {props.value}
    </button>
  );
}

export default Game;