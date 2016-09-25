import React from 'react';

// Fun stats relative to other random distances/durations
export const FunFact = React.createClass({
  randomComparison: function () {
    const comparisons = [
      // Height of empire state building
      (km, days) => {
        let height = 0.443;
        let multiplier = Math.round(km / height);
        return `Grey has now travelled ${multiplier.toLocaleString()} times the height of the empire state building`
      },

      // Circumference of the moon
      (km, days) => {
        const circumference = 10921;
        let multiplier = Math.round(km * 10 / circumference) / 10;
        return `Grey has now covered ${multiplier.toLocaleString()} times the circumference of the moon`
      },

      // Mars bars (calories)
      (km, days) => {
        const caloriesPerDay = 6000; // estimated...
        const totalCalories = caloriesPerDay * days;
        const caloriesInMarsBar = 260;

        let multiplier = Math.round(totalCalories / caloriesInMarsBar);
        return `Grey has now consumed approximately ${multiplier.toLocaleString()} Mars Bars worth of calories`
      }
    ];

    return comparisons[(Math.random() * comparisons.length) | 0];
  },

  getInitialState: function () {
    const fact = this.randomComparison()(
      this.props.distance,
      this.props.daysOnTheRoad
    );

    return { fact: fact };
  },

  render: function() {
    return <div className="fun-fact">Fun fact: {this.state.fact}</div>
  }
});

