<template>
  <details>
    <summary>点击展开</summary>
    <div class="content">这里是展开后的内容，原生支持 Ctrl+F 页内搜索！</div>
  </details>

  <dialog id="myModal">
    <form method="dialog">
      <p>这是一个原生模态框</p>
      <button>关闭（自动）</button>
    </form>
  </dialog>

  <button onclick="myModal.showModal()">打开弹窗⏏</button>
</template>
<script setup>
import { version } from "vue";
console.log(version, 111);
</script>

<style scoped>
details {
  border: 1px solid #ccc;
  border-radius: 6px;
  padding: 8px;
}

summary {
  cursor: pointer;
  font-weight: bold;
}

/* 包住内容，让它能动画高度 */
details > .content {
  overflow: hidden;
  max-height: 0;
  opacity: 0;
  transition: max-height 0.45s ease, opacity 0.3s ease;
}

/* details 处于 open 状态时 */
details[open] > .content {
  max-height: 200px; /* 你内容高度大概多少设多少，足够大即可 */
  opacity: 1;
}

/* 背景遮罩 */
dialog::backdrop {
  background: rgba(0, 0, 0, 0.45);
  backdrop-filter: blur(3px);
  transition: opacity 0.3s ease;
}
</style>
