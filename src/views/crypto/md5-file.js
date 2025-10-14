import fs from "fs";
import crypto from "crypto";

const FILE_PATH = "./test.json"

// 计算文件 MD5  node环境
function calcFileMD5(filePath) {
    const buffer = fs.readFileSync(filePath);
    return crypto.createHash("md5").update(buffer).digest("hex")
}

const md5 = calcFileMD5(FILE_PATH);

console.log(`${FILE_PATH} => ${md5}`)

/**
 * 文件上传时要用 MD5 重命名
 * MD5 生成固定成都的 32 位十六进制字符串，跨平台计算结果一致，不受操作系统、编程语言或框架影响。
 * MD5 属于单向哈希算法，即使获取到哈希值，也难以直接反推出原始内容，因此在一定程度上可防止文件内容泄漏。
 */