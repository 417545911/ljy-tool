<script setup>
import { useDark, useToggle } from "@vueuse/core";

const isDark = useDark();
const toggleDark = useToggle(isDark);
</script>

<template>
  <el-button @click="toggleDark()">{{ isDark ? "dark" : "light" }}</el-button>
  <router-view />
</template>
