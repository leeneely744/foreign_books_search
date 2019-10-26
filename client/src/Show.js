import React from 'react';
import { For } from 'react-loops'

export default function Show(props) {
  let books = Object.values(props.books)
  return (
    <ul>
      <For of={books} ifEmpty={<h1>書籍がありません。</h1>}>
        {book =>
          <li>
            <button onClick={() => props.onClickBookLink(true)}>
              {book.title}
            </button>
          </li>
        }
      </For>
    </ul>
  );
}