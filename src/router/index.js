import { createRouter, createWebHistory } from "vue-router";
import Layoout from "@/layout/index.vue";

/**
 * 将views下面的直系子级文件夹下面的index.vue,文件夹自动导入静态路由，匹配 src/views
 * 排除嵌套级别目录下的index.vue
 */
const modules = import.meta.glob(["../views/*/index.vue"]);
const defaultRoutes = [];
for (const module in modules) {
  const moduleName = module.split("/")[2];
  defaultRoutes.push({
    name: moduleName,
    path: "/" + moduleName,
    component: modules[module],
  });
}

const routes = [
  ...defaultRoutes,
  {
    path: "/office",
    name: "Office",
    component: Layoout,
    redirect: "/office/xlsx",
    children: [
      {
        name: "Xlsx",
        path: "xlsx",
        component: () => import("@/views/xlsx/index.vue"),
      },
    ],
  },
];

export const router = createRouter({
  history: createWebHistory(),
  routes,
  scrollBehavior: () => ({ left: 0, top: 0 }),
});

export default router;
