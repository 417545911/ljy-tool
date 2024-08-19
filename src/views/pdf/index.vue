<script setup>
import { ref } from "vue";
import axios from "axios";

const file = ref(null);
const downloadUrl = ref("");

const handleFile = (event) => {
  file.value = event.target.files[0];
};

const convertFile = async () => {
  if (!file.value) {
    alert("Please select a file first");
    return;
  }

  const formData = new FormData();
  formData.append("file", file.value);

  try {
    const response = await axios.post(
      "http://127.0.0.1:8000/convert/",
      formData,
      {
        responseType: "blob",
      }
    );

    const url = window.URL.createObjectURL(new Blob([response.data]));
    downloadUrl.value = url;

  } catch (error) {}
};
</script>

<template>
  <div class="flex p-4 justify-center">
    <input type="file" @change="handleFile" accept=".pdf" />
    <div
      class="hover:opacity-80 active:opacity-70 cursor-pointer rounded-xl bg-black px-5 flex items-center text-white"
      @click="convertFile"
    >
      转成word
    </div>
    <div v-if="downloadUrl">
      <a :href="downloadUrl" download="converted.docx">下载docx文件</a>
    </div>
  </div>
  
</template>
