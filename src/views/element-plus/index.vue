<template>
  <div class="test-container">
    <h3>Element Plus 内存泄漏测试</h3>
    
    <el-button @click="toggleDialog" type="primary">
      {{ dialogVisible ? '关闭' : '打开' }}对话框
    </el-button>
    
    <el-button @click="triggerGC" type="warning">
      强制垃圾回收
    </el-button>

    <!-- 关键：添加ref -->
    <el-dialog
      ref="dialogRef"
      v-model="dialogVisible"
      title="测试对话框"
      width="30%"
      :destroy-on-close="true"
      @opened="onDialogOpened"
    >
      <div class="dialog-content">
        <p>这是一个测试对话框内容</p>
      </div>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, nextTick } from 'vue'

// 关键：通过ref引用对话框
const dialogRef = ref(null)
const dialogVisible = ref(false)
const instanceCount = ref(0)

// 每个对话框实例分配一个唯一ID
const trackedDialogs = new Map()

// 创建 FinalizationRegistry
const finalizerRegistry = new FinalizationRegistry((dialogId) => {
  console.log(`✅ 对话框实例被回收: Dialog_${dialogId}`)
  trackedDialogs.delete(dialogId)
})

// 显示/隐藏对话框
const toggleDialog = async () => {
  dialogVisible.value = !dialogVisible.value
  
  if (dialogVisible.value) {
    instanceCount.value++
    const dialogId = instanceCount.value
    
    // 等待对话框完全渲染
    await nextTick()
    
    if (dialogRef.value) {
      // 获取对话框的实际实例
      const dialogInstance = dialogRef.value
      
      // 注册追踪
      finalizerRegistry.register(dialogInstance, dialogId)
      trackedDialogs.set(dialogId, dialogInstance)
      
      console.log(`🚀 创建对话框实例: Dialog_${dialogId}`)
    }
  } else {
    console.log('📁 对话框已关闭，等待垃圾回收...')
  }
}

// 强制垃圾回收
const triggerGC = () => {
  if (window.gc) {
    window.gc()
    console.log('🧹 已手动触发垃圾回收')
  } else {
    console.log('⚠️ 请在Chrome中启用 --js-flags="--expose-gc"')
  }
}
</script>