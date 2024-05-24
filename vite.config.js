import { defineConfig, loadEnv } from "vite";
import vue from "@vitejs/plugin-vue";

// https://vitejs.dev/config/
export default defineConfig(({ command, mode }) => {
  const env = loadEnv(mode, process.cwd());
  return {
    plugins: [
      vue(), // 自定义插件
      {
        name: "custom-hot-reload",
        apply: "serve",
        // 服务工作开始时调用
        serverStart({ server }) {
          // 监听文件变化
          console.info("🐕‍🦺 ", env.VITE_ADDITIONAL_WATCH_FILES);
          server.watchAdditionalPaths(
            
          );
        },
        // 文件变化时调用
        handleHotUpdate(ctx) {
          // 执行自定义的热重载逻辑
          console.log("File updated:", ctx.file);
          // 你可以在这里添加更多的逻辑，例如重新加载组件、应用更新等。
        },
      },
    ],
  };
});
