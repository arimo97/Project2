<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
<body>

<canvas id="myChart5" style="width:100%;max-width:600px"></canvas>

<script>
var xValues = ["미국", "중국", "일본", "독일", "영국", "인도","프랑스","이탈리아","대한민국","기타"];
var yValues = [55, 49, 44, 24, 15, 10, 20, 30, 40, 50];
var barColors = [
  "#b91d47",
  "#00aba9",
  "#2b5797",
  "#e8c3b9",
  "#1e7145",
  "#8A2BE2",
  "#45484B",
  "#FF7F50",
  "#00FFFF",
  "#FF8C00"
];

new Chart("myChart5", {
  type: "pie",
  data: {
    labels: xValues,
    datasets: [{
      backgroundColor: barColors,
      data: yValues
    }]
  },
  options: {
    title: {
      display: true,
      text: "World Wide Wine Production 2018"
    }
  }
});
</script>

</body>
</html>
