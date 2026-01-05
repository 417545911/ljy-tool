<script setup>
import com from "./com.vue";
import { ref } from "vue";

let msg = ref("测试");
</script>

<template>
  <com :foo="msg"> </com>
  <el-input v-model="msg"></el-input>
</template>

<style></style>
