<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<body>
<div
id="myChart5" style="width:auto; max-width:600px; height:500px;">
</div>

<script>
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart);

var html ='';
html += '['Contry', 'Mhl'],';
html += '['Italy',54.8],';
html += '['France',48.6],';
html += '['Spain',44.4],';
html += '['USA',23.9],';
html += '['Argentina',14.5],';
html += '['korea',11.5]';

function drawChart(html) {
var data = google.visualization.arrayToDataTable([
	
	html 
/*   ['Contry', 'Mhl'],
  ['Italy',54.8],
  ['France',48.6],
  ['Spain',44.4],
  ['USA',23.9],
  ['Argentina',14.5],
  ['korea',11.5] */

]);

var options = {
  title:'World Wide Wine Production',
  is3D:true
};

var chart = new google.visualization.PieChart(document.getElementById('myChart5'));
  chart.draw(data, options);
}
</script>

</body>
</html>



