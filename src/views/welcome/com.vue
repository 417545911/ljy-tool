<script setup>
import { watchEffect, watch, isRef } from "vue";
const { foo } = defineProps(["foo"]);

watch(
  () => foo,
  (newVal) => {
    console.info("🐕‍🦺 ~file: com.vue ~line: 6 ~newVal", newVal);
  }
);
</script>

<style></style>
