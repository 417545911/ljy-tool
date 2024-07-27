<script setup>
import { ref } from "vue";
import { read, utils,writeFile } from "xlsx";

const tableData = ref([]);

// 导入文件
const handleFile = (event) => {
  const file = event.target.files[0];
  const reader = new FileReader();
  // 处理文件内容
  reader.onload = (e) => {
    const data = new Uint8Array(e.target.result);
    const workbook = read(data, { type: "array" });

    workbook.SheetNames.forEach((sheetName, index) => {
      // 获取表头年份
      const year = sheetName.slice(0, 4);
      // 获取表内容，转json格式
      const worksheet = workbook.Sheets[workbook.SheetNames[index]];
      const jsonData = utils.sheet_to_json(worksheet, { header: 1 });
      // 格式化json
      const headerArr = jsonData[0];
      const tem = [];
      jsonData.slice(1).map((arr, idx) => {
        arr.map((company, headerIdx) => {
          tem.push({
            company: company.trim(),
            year,
            reward: headerArr[headerIdx].trim(),
          });
        });
      });
      tableData.value = tableData.value.concat(tem);
    });
  };
  // 读取文件内容
  reader.readAsArrayBuffer(file);
};

// 导出xls
const exportExcelFile=(array, sheetName = 'sheet1', fileName = '2017-2023.xlsx') =>{
  const jsonWorkSheet = utils.json_to_sheet(array);
  const workBook = {
    SheetNames: [sheetName],
    Sheets: {
      [sheetName]: jsonWorkSheet,
    }
  };
  return writeFile(workBook, fileName);
}

</script>

<template>
  <div class="flex p-4 justify-center">
    <input type="file" @change="handleFile" accept=".xlsx,.xls" />
    <div class="hover:opacity-80 active:opacity-70 cursor-pointer rounded-xl bg-black px-5 flex items-center text-white" @click="exportExcelFile(tableData)">导出</div>
  </div>
  <div class="w-[600px] mt-10 m-auto border-2 rounded-md">
    <el-table :data="tableData" stripe height="600">
      <el-table-column prop="company" label="公司" sortable />
      <el-table-column prop="reward" label="评级" sortable />
      <el-table-column prop="year" label="年份" sortable />
    </el-table>
  </div>
</template>

<style></style>
