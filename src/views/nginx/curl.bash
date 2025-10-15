 
 echo "开始下载iconfont..."
 
curl --output ./test.zip 'https://www.iconfont.cn/api/project/download.zip?spm=a313x.manage_type_myprojects.i1.d7543c303.1bc53a81xGoCXO&pid=5041371&ctoken=null' \
  -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7' \
  -H 'accept-language: zh-CN,zh;q=0.9,en;q=0.8,zh-TW;q=0.7' \
  -H 'cache-control: no-cache' \
  -b 'cna=Kj1MIarjhzQBASQIhFnd6Oor; EGG_SESS_ICONFONT=Hu68kBY7XO7C6Udp3T99M1asKmUZ0gxjps8xjTrjx4b-3zxfBboXmPdJZotOF1-QPN0IhA_WNQ7ERnO6TGzbhYG_eioqkYhGDtx9UFVb0Cdp8MNtmDns86Q4pwBLsEvq2hOTCKK5NOHQqUJO6vi9t7aSZ-ZyIhxs-3VJMMC-dkAzXCIkCzbMQ2rPTqDy-WPz-aiPARdp-0nol9ed7uAPs_CAf-bjjlntfoinIPZCdk-d9HxalqvDusAiEIeequJcDycepFmTR6QD6i3Z6c5lGjZyGG-xnz8CBDlEobJ5xm1BNnrHVqZBpopXiWUUcyk8Q72DRtha4ytxoj6FbqZhZj9Joh2OUkJcAJ2evwFnLm4=; u=10643872; u.sig=eiBdt6av3Pf1JBnOh83FF7GcLJrrM7FfniJd9_0chKc; xlly_s=1; iconfont_has_read_tip=1; tfstk=g7TIUtj6ZLLwIyKAAalafjAqPrb7FfuqF71JiQUUwwQLe8dAQB8F8QrWFdOA2eRPJU_WCL9eYwKeV_929LsotTWRFLRJYfuquBAhrapS3qu4EyAxLpwde9hRX_1K_6Qe74LPraHqQlzRxq_kpOPk3gdt1_5zeypRv5FOI_a8eLBdXRCfiaBJeLITBs5u9JC8vPdOI_QReLQ-1NBGNaBJeah66f2bN1kcIBGA3SWY1vH7qOU8yF1CXcRdBt7ZaMjCSB6sHeYhO-Xv9Oa8PtN90NOJeYaPknv6PipqPPbeGhQOOhG8X9IXvp5MFqadpFOpJ98KQyWp-CK2zdh8yTt9Dixv9Ar11hde5G8xhzsHXpxcVUkZow-2gUjvJ2wcQifWhwKsBy9A46zVh9l7V5s0P16q1fZuqej51K_Eonu5v1fZYfG_0gsds1GI1fZuqMCG_6cs1oS5.' \
  -H 'pragma: no-cache' \
  -H 'priority: u=0, i' \
  -H 'referer: https://www.iconfont.cn/manage/index?manage_type=myprojects&projectId=5041371' \
  -H 'sec-ch-ua: "Google Chrome";v="143", "Chromium";v="143", "Not A(Brand";v="24"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "macOS"' \
  -H 'sec-fetch-dest: document' \
  -H 'sec-fetch-mode: navigate' \
  -H 'sec-fetch-site: same-origin' \
  -H 'sec-fetch-user: ?1' \
  -H 'upgrade-insecure-requests: 1' \
  -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36'
  --compressed

 unzip -j ./test.zip -d ./test
 mv ./test/iconfont.js ./iconfont.js
 rm -rf ./test
 rm -rf ./test.zip

 echo "iconfont下载完成"