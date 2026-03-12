<!-- AsyncComponent.vue -->
<template>
  <div>
    <h2>我是异步加载的组件{{ count }}</h2>
    <p>{{ message }}</p>
  </div>
</template>

<script setup>
defineProps(["count"]);
// 这个组件会被异步加载
const message = "Hello from Async Component!";
</script>
