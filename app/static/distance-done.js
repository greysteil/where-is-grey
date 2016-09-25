import React from 'react';

export const DistanceDone = React.createClass({
  render: function() {
    var daysOnTheRoad = this.props.daysOnTheRoad;
    var distance = this.props.distance;

    return (
      <div className="stat">
        <div className="stat-heading">DISTANCE TRAVELLED</div>
        <div className="stat-body">
          <span className="stat-value">{Math.round(distance).toLocaleString()}</span>
          <span className="stat-unit">km</span>
        </div>
        <div className="stat-footer">{daysOnTheRoad} days on the road</div>
      </div>
    );
  }
});

