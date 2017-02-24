import React from 'react';

export const DistanceRemaining = React.createClass({
  render: function() {
    return (
      <div className="stat">
        <div className="stat-heading">distance to go</div>
        <div className="stat-body">
          <span className="stat-value">{Math.round(this.props.distance).toLocaleString()}</span>
          <span className="stat-unit">km</span>
        </div>
        <div className="stat-footer">next up: <span dangerouslySetInnerHTML={{__html: "London"}}></span></div>
      </div>
    );
  }
})

