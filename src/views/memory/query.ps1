param (  
    [int]$Param1  
)  

# 定义1MB的字节数  
$1MB = 1024 * 1024  

# 初始化一个空数组来存储进程信息  
$processesArray = @()  

while ($true) { # 无限循环  
    # 获取当前时间戳（这次用于添加到每一行数据中）    
    $currentTimestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"    
            
    # 获取进程信息，但不使用 Format-Table    
    if (Get-Process -Id $Param1) {  
        $processInfo = Get-Process -Id $Param1 | Select-Object @{  
            # 单位 MB
            Name="memory";   
            Expression={[Math]::Round($_.PrivateMemorySize64 / $1MB, 2)}  
        }, @{  
            Name="time";   
            Expression={$currentTimestamp}  
        }  
        
        # 将这次循环的进程信息添加到数组中  
        $processesArray += $processInfo  
    } else {  
        Write-Host "Process ID $Param1 not found."  
        Start-Sleep -Seconds 2 # 等待2秒再尝试  
        continue # 跳过本次循环的剩余部分  
    }  

    # 如果需要，可以设置一个条件来限制数组的大小，比如当数组达到100个元素时清空或写入文件  

    # 假设我们每次循环都写入文件  
    # 将整个数组转换为 JSON 格式的字符串  
    $jsonProcesses = ConvertTo-Json -Depth 100 -InputObject $processesArray  

    # 将 JavaScript 数组保存到 output.js 文件中  
    $jsonProcesses| Out-File -FilePath "\Github\ljy-tool\src\assets\output.json" -Encoding UTF8  # 使用 -Append 参数追加内容到文件  

    Start-Sleep -Seconds 2 # 等待2秒   
}  
    
# 注意：这个脚本会无限循环，直到你手动停止它（例如，通过Ctrl+C）