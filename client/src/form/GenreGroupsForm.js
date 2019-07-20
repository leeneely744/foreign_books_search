import React, { Component } from 'react';
import { makeStyles } from '@material-ui/core/styles';
import List from '@material-ui/core/List';
import ListItem from '@material-ui/core/ListItem';
import ListItemText from '@material-ui/core/ListItemText';
import Checkbox from '@material-ui/core/Checkbox';
import ExpandLess from '@material-ui/icons/ExpandLess';
import ExpandMore from '@material-ui/icons/ExpandMore';
import { ExpansionPanel, Typography, ExpansionPanelDetails, ListItemSecondaryAction } from '@material-ui/core';

export default class GenreGroupForm extends Component {
  constructor(props) {
    super(props);
    this.state = {
      open: false
    };
  }

  handleClick = () => this.setState({open: !open});

  render() {
    const genreGroups = Object.values(this.props.genreGroups);

    return (
      <List className="GenreGroup">
        {genreGroups.map(genreGroup => {
          const labelId = `genreGroup-list-label`;

          return (
            <div>
              <ListItem button onClick={this.handleClick}>
                <ListItemText primary={genreGroup.booksGenreName}/>
                {open ? <ExpandLess /> : <ExpandMore />}
              </ListItem>
            </div>
          );
        })}
      </List>
    );
  }
}

const genreGroupStyles = makeStyles(theme => ({
  root: {
  },
  heading: {
    fontSize: theme.typography.pxToRem(15),
    flexBasis: '33.33%',
    flexShrink: 0,
  },
  secondaryHeading: {
    fontSize: theme.typography.pxToRem(15),
    color: theme.palette.text.secondary,
  },
  list: {
    backgroundColor: theme.palette.background.paper,
  }
}));

/**
 * props の例
 *  [
 *    id: 1,
 *    booksGenreName: "Travel（旅行）",
 *    genres: [
 *      0: [
 *        booksGenreId: "005409001",
 *        booksGenreName: "Transportation"
 *      ],
 *      1: ...
 *    ]
 *  ]
 */
function GenreGroup(props) {
  const classes = genreGroupStyles();
  const [expanded, setExpanded] = React.useState(false);
  const genres = props.genres;

  const handleChange = panel => (event, isExpanded) => {
    setExpanded(isExpanded ? panel : false);
  };

  return (
    <ExpansionPanel
     expanded={expanded === `genre-group-${props.id}`}
     onChange={handleChange(`genre-group-${props.id}`)}
    >
      <Typography className={classes.heading}>${props.booksGenreName}</Typography>
      <ExpansionPanelDetails>
        <List className={classes.list}>
          {genres.map((genre, id) => {
            <Genre genre={genre} id={id} />
          })}
        </List>
      </ExpansionPanelDetails>
    </ExpansionPanel>
  );
}


/**
 * props の例
 *  [
 *    booksGenreId"005409001",
 *    booksGenreName: "Transportation"
 *  ]
 */
function Genre(props) {
  const id = props.id;
  const [checked, setChecked] = React.useState([false]);

  const handleToggle = () => setChecked(!checked);

  return (
    <ListItem key={id}>
      <ListItemText
       id={`genre${id}`}
       primary={props.booksGenreName}
      />
      <ListItemSecondaryAction>
        <Checkbox
          edge="end"
          onChange={handleToggle(id)}
          checked={checked}
          inputProps={{
            'aria-labelledby': id
          }}
        />
      </ListItemSecondaryAction>
    </ListItem>
  );
}
