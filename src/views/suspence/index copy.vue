<!-- ParentComponent.vue -->
<template>
  <AsyncComponent />
</template>

<script setup>
import { defineAsyncComponent } from "vue";
import LoadingComponent from "./LoadingComponent.vue";

// 定义一个异步组件
const AsyncComponent = defineAsyncComponent({
  loader: () => {
    // 模拟延迟，确保总加载时间超过 delay 时间
    return new Promise((resolve) => {
      setTimeout(() => {
        resolve(import("./AsyncComponent.vue"));
      }, 6000);
    });
  },
  loadingComponent: LoadingComponent,
  // delay 的含义是：在显示 loadingComponent 组件加载。
  delay: 200,
});
</script>
