<!-- ParentComponent.vue -->
<template>
  <Suspense>
    <template #default>
      <div>
        <AsyncComponent :count="1" />
        <AsyncComponent2 :count="2" />
      </div>
    </template>
    <!-- 在 #fallback 插槽中显示 “正在加载中” -->
    <template #fallback> Loading22... </template>
  </Suspense>
</template>

<script setup>
import { defineAsyncComponent } from "vue";
import LoadingComponent from "./LoadingComponent.vue";

// 定义第一个异步组件
const AsyncComponent = defineAsyncComponent({
  loader: () => {
    // 模拟延迟，确保总加载时间超过 delay 时间
    return new Promise((resolve) => {
      setTimeout(() => {
        resolve(import("./AsyncComponent.vue"));
      }, 6000);
    });
  },
  // suspense 接管了加载状态
  loadingComponent: LoadingComponent,
  // delay 的含义是：在显示 loadingComponent 组件加载。
  delay: 200,
});

// 定义第一个异步组件
const AsyncComponent2 = defineAsyncComponent({
  loader: () => {
    // 模拟延迟，确保总加载时间超过 delay 时间
    return new Promise((resolve) => {
      setTimeout(() => {
        resolve(import("./AsyncComponent.vue"));
      }, 2000);
    });
  },
});
</script>
