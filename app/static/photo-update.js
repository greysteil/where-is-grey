import React from 'react';
import moment from 'moment';

import {countryFromLatLong} from './utils';

export const PhotoUpdate = React.createClass({
  getInitialState: function() {
    return {
      country: null
    };
  },

  componentWillReceiveProps: function(newProps) {
    var latestCheckin = newProps.data.latestCheckin;

    countryFromLatLong(newProps.data.lat, newProps.data.lng)
      .then((country) => this.setState({ country: country }));
  },

  render: function() {
    return (
      <div className="photo-update">
        <div className="photo-update__photo">
          <img src={this.props.data.url} width="100%"/>
        </div>
        <div className="photo-update__details">
          <div className="photo-update__title">{this.state.country}, {moment(this.props.data.taken_at).format('MMMM Do')}</div>
          <div className="photo-update__caption">{this.props.data.description}</div>
        </div>
      </div>
    );
  }
});
