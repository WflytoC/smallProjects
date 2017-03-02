import React,{Component} from 'react';
import './Item.css';

class Item extends Component {

	render() {
		const content = this.props.subs.map(function(sub) {
			return (<div className="Sub"><a href={sub.url} target="__blank">{sub.desc}</a></div>);
		});
		return (
			<div className="Item">
				{content}
			</div>
		);
	}
}

export default Item;