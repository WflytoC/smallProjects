import React, { Component } from 'react';
import './App.css';
import Item from './Item.js';
import data from '../favorites.json';

class App extends Component {

	constructor(props) {
		super(props);
		this.state = {contents: {}}
	}

	componentWillMount() {
		this.setState({contents: data});
	}


  	render() {
  		const contentKeys = Object.keys(this.state.contents);
  		const contentIsEmpty = (contentKeys.length <= 0);
  		if (contentIsEmpty) {
  			return (
  				<div>
  					Content is blank
  				</div>
  			);
  		}
  		const contents = this.state.contents;
  		const content = contentKeys.map(function(contentKey) {
  			return (
  				<div className="block">
  					<div className="header">{contentKey}</div>
  					<Item subs={contents[contentKey]}/>
  				</div>
  			);
  		});

    	return (
      		<div className="App">
        		{content}
      		</div>
    	);
  	}
}

export default App;
