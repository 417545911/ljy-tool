<script setup>
import "highlight.js/styles/stackoverflow-dark.css";
import hljs from "highlight.js/lib/core";
import nginx from "highlight.js/lib/languages/nginx";
import { ref } from "vue";
hljs.registerLanguage("nginx", nginx);
const highlightedCode = ref();
const originalCode = `
server {
    listen 80;  # 监听80端口，HTTP请求的默认端口
    client_max_body_size 100m;  # 设置客户端请求体的最大大小为100MB
    index index.html;  # 设置默认的索引文件为index.html
    root /user/project/admin;  # 设置Web内容的根目录为/user/project/admin

    # 路由配置，处理所有URL路径
    location ~ /* {
        proxy_pass http://127.0.0.1:3001;  # 将请求代理到本机的3001端口
        proxy_redirect off;  # 关闭代理重定向

        # 设置代理请求头，以便后端服务器可以获取客户端的原始信息
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

        # 定义代理服务器失败时的行为，如遇到错误、超时等，尝试下一个后端服务器
        proxy_next_upstream error timeout invalid_header http_500 http_502 http_503 http_504;
        proxy_max_temp_file_size 0;  # 禁止代理临时文件写入

        # 设置代理连接、发送和读取的超时时间
        proxy_connect_timeout 90;
        proxy_send_timeout 90;
        proxy_read_timeout 90;

        # 设置代理的缓冲区大小
        proxy_buffer_size 4k;
        proxy_buffers 4 32k;
        proxy_busy_buffers_size 64k;
        proxy_temp_file_write_size 64k;
    }

    # 对图片文件设置缓存过期时间，客户端可以在1天内使用本地缓存
    location ~ .*.(gif|jpg|jpeg|png|swf)$ {
        expires 1d; 
    }

    # 对JavaScript和CSS文件设置缓存过期时间，客户端可以在24小时内使用本地缓存
    location ~ .*.(js|css)?$ {
        expires 24h;
    }

    # 允许访问/.well-known目录下的所有文件，通常用于WebFinger、OAuth等协议
    location ~ /.well-known {
        allow all;
    }

    # 禁止访问隐藏文件，即以点开头的文件或目录
    location ~ /. {
        deny all;
    }

    # 指定访问日志的路径，日志将记录在/user/logs/admin.log文件中
    access_log /user/logs/admin.log;
}

`
highlightedCode.value = hljs.highlight(originalCode, { language: "nginx" }).value

</script>

<template>
  <div class="whitespace-pre pl-40" v-html="highlightedCode">
  </div>
</template>
