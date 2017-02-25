import React from 'react';
import moment from 'moment';

export const CheckinLocation = React.createClass({
  randomLocationDescription: function() {
    var descriptions = [
      'currently hurtling through',
      'currently rolling through',
      'currently racing through',
      'currently enjoying the scenery of',
      'currently located in',
      'currently in',
      'currently travelling through',
    ];

    return descriptions[(Math.random() * descriptions.length) | 0]
  },

  getInitialState: function () {
    return { locationDescription: this.randomLocationDescription() };
  },

  render: function() {
    var timeAgo = moment(this.props.time).fromNow();
    var location = this.props.country;

    return (
      <div className="stat">
        <div className="stat-heading">{this.state.locationDescription}</div>
        <div className="stat-body">🎉 {location} 🎉</div>
        <div className="stat-footer">last checked in {timeAgo}</div>
      </div>
    );
  }
});

