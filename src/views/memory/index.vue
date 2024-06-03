<script setup>
import { ref, onMounted, nextTick } from "vue";
import * as echarts from "echarts";
import Clock from "../../components/clock/index.vue";

const chartDom = ref(null);
let option, timeData, memoryData, myChart;
onMounted(async () => {
  await nextTick();
  myChart = echarts.init(chartDom.value);

  initChart();

  setInterval(() => {
    fetch(`/src/assets/output.json?timestamp=${Date.now()}`)
      .then((response) => response.json())
      .then((data) => {
        timeData = data.map((el) => el.time);
        memoryData = data.map((el) => el.memory);
        updateData();
      });
  }, 2000);
});

function initChart() {
  option = {
    title: {
      left: "left",
      text: "",
    },
    animation: false,
    hoverLayerThreshold: 999999,
    tooltip: {
      trigger: "axis",
      axisPointer: {
        type: "cross",
      },
      backgroundColor: "rgba(255, 255, 255, 0.8)",
      formatter: "时间: {b0}<br />内存(MB): {c0}",
      extraCssText: "width: 170px",
    },
    xAxis: {
      type: "category",
      data: [],
      scale: true,
      axisLabel: {
        formatter: (value) => {
          return value.slice(-8, -3);
        },
      },
    },
    yAxis: {
      type: "value",
    },
    series: [
      {
        name: "内存使用量",
        symbol: "none",
        data: [],
        type: "line",
        smooth: true,
        lineStyle: { color: "rgba(58,143,255,0.5)", width: 2 },
        areaStyle: { color: "rgba(58,143,255,0.2)", origin: "start" },
        emphasis: {
          disabled: true,
        },
      },
    ],
  };

  option && myChart.setOption(option);
}
function updateData() {
  myChart.setOption({
    xAxis: { data: timeData },
    series: [{ name: "内存使用量", data: memoryData }],
  });
}
</script>

<template>
  <div>
    <!-- <Clock /> -->
    <div style="text-align: center">
      每2s浏览器指定tab内存使用量
    </div>
    <div
      ref="chartDom"
      style="width: 1500px; height: 700px; margin: 0 auto"
    ></div>
  </div>
</template>
