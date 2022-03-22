window.onload = function() {
  var $chart = document.getElementById("chart");
  if (!$chart) {
    return;
  }

  google.charts.load('current', {packages: ['corechart']});
  google.charts.setOnLoadCallback(drawCharts);

  function drawTotalClicksChart() {
    var data = google.visualization.arrayToDataTable([
      ['day', 'clicks'],
    ].concat(chartData.totalClicksChart));

    var options = {
      title: 'total clicks',
      haxis: {
        title: 'day of month'
      },
      vaxis: {
        title: 'clicks'
      }
    };

    var chart = new google.visualization.AreaChart(document.getElementById('total-clicks-chart'));
    chart.draw(data, options);
  }

  function drawBrowsersChart() {
    var data = google.visualization.arrayToDataTable([
      ['browser', 'clicks'],
    ].concat(chartData.platformsChart));

    var options = {
      title: 'Browsers'
    };

    var chart = new google.visualization.PieChart(document.getElementById('browsers-chart'));
    chart.draw(data, options);
  }

  function drawPlatformsChart() {
    var data = google.visualization.arrayToDataTable([
      ['platform', 'clicks'],
    ].concat(chartData.browserChart));

    var options = {
      title: 'Platform'
    };

    var chart = new google.visualization.PieChart(document.getElementById('platforms-chart'));
    chart.draw(data, options);
  }

  function drawCharts() {
    drawTotalClicksChart();
    drawBrowsersChart();
    drawPlatformsChart();
  }
};
