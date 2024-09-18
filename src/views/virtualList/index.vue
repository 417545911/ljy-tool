<script setup>
import { ref,nextTick } from "vue";
import dayjs from "dayjs"

const listArr = ref([]);
const addDomHandler = async () => {
  // 记录任务开始时间
  let now = Date.now();
  listArr.value = new Array(10000).fill(Math.random());
  console.log('js运行后时间：', Date.now() - now)
  await nextTick(); // 等待DOM更新
  console.log('总运行时间：', Date.now() - now)
};
</script>

<template>
  <el-button @click="addDomHandler">添加dom</el-button>
  <ul>
    <li v-for="item in listArr" :key="item">
      {{ item }}
    </li>
  </ul>
</template>

<style></style>