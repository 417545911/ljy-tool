import { createRouter, createMemoryHistory } from "vue-router";

const modules = import.meta.glob(["./module/**/*.js"], { eager: true });

const routes = [];

Object.keys(modules).forEach((key) => {
  routes.push(modules[key].default);
});

export const router = createRouter({
  history: createMemoryHistory(),
  routes,
});

export default router;
