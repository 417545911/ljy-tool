import { createRouter, createWebHistory  } from "vue-router";

const routes = [
  {
    path: "/welcome",
    name: "Welcome",
    component: () => import("@/views/welcome/index.vue"),
  },
  {
    path: "/xlsx",
    name: "Xlsx",
    component: () => import("@/views/xlsx/index.vue"),
  },
];

export const router = createRouter({
  history: createWebHistory (),
  routes,
  scrollBehavior: () => ({ left: 0, top: 0 }),
});

export default router;
