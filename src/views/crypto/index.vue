<template>
  <div class="file-hash-calculator">
    <h3>文件哈希值计算（浏览器环境）</h3>
    <input 
      type="file" 
      @change="handleFileChange" 
      :disabled="calculating"
    />
    <div v-if="selectedFile" class="file-info">
      <p>已选择文件: <strong>{{ selectedFile.name }}</strong> ({{ formatFileSize(selectedFile.size) }})</p>
    </div>
    <div v-if="calculating" class="progress-info">
      <p>计算中，请稍候... {{ hashProgress.toFixed(1) }}%</p>
      <progress :value="hashProgress" max="100"></progress>
    </div>
    <div v-if="fileHash" class="result-info">
      <p>文件哈希值 (MD5):</p>
      <code>{{ fileHash }}</code>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import SparkMD5 from 'spark-md5';

// 响应式数据
const selectedFile = ref(null);
const fileHash = ref('');
const calculating = ref(false);
const hashProgress = ref(0);

// 处理文件选择
const handleFileChange = (event) => {
  const file = event.target.files[0];
  if (!file) return;

  selectedFile.value = file;
  fileHash.value = ''; // 重置哈希值
  calculateFileHash(file);
};

// 计算文件哈希值
const calculateFileHash = (file) => {
  calculating.value = true;
  hashProgress.value = 0;

  // 使用 FileReader 和 SparkMD5 计算哈希
  const spark = new SparkMD5.ArrayBuffer(); // 使用 ArrayBuffer 处理二进制数据，对大文件更友好[8](@ref)
  const fileReader = new FileReader();
  const chunkSize = 2 * 1024 * 1024; // 每次读取2MB，用于支持大文件的分块计算[2,4](@ref)
  const chunks = Math.ceil(file.size / chunkSize);
  let currentChunk = 0;

  fileReader.onload = function (e) {
    // 将读取到的数组缓冲区数据追加到 SparkMD5 实例中[8](@ref)
    spark.append(e.target.result);
    currentChunk++;

    // 更新计算进度
    if (currentChunk < chunks) {
      hashProgress.value = (currentChunk / chunks) * 100;
      loadNextChunk();
    } else {
      // 所有分块读取完毕，计算最终哈希值
      hashProgress.value = 100;
      // spark.end() 方法返回最终的哈希值（十六进制字符串）[8,9](@ref)
      fileHash.value = spark.end();
      calculating.value = false;
    }
  };

  fileReader.onerror = function () {
    console.error('文件读取失败');
    calculating.value = false;
  };

  const loadNextChunk = () => {
    const start = currentChunk * chunkSize;
    const end = start + chunkSize >= file.size ? file.size : start + chunkSize;
    const chunk = file.slice(start, end); // 使用 slice 方法切割文件[4,6](@ref)
    fileReader.readAsArrayBuffer(chunk); // 读取为 ArrayBuffer[8](@ref)
  };

  loadNextChunk(); // 开始读取第一个分块
};

// 辅助函数：格式化文件大小显示
const formatFileSize = (bytes) => {
  if (bytes === 0) return '0 B';
  const k = 1024;
  const sizes = ['B', 'KB', 'MB', 'GB'];
  const i = Math.floor(Math.log(bytes) / Math.log(k));
  return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
};
</script>

<style scoped>
.file-hash-calculator {
  max-width: 600px;
  margin: 20px auto;
  padding: 20px;
  border: 1px solid #eee;
  border-radius: 8px;
  font-family: sans-serif;
}

input[type="file"] {
  margin: 10px 0;
}

.file-info, .progress-info, .result-info {
  margin-top: 15px;
}

progress {
  width: 100%;
  margin-top: 5px;
}

code {
  display: block;
  background-color: #f5f5f5;
  padding: 10px;
  border-radius: 4px;
  word-break: break-all;
  margin-top: 5px;
}
</style>
