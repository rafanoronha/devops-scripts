# cache manager name
$cache_manager = 'MyCacheManagerName'

# collection of cache names
$cache_names = 'cacheA','cacheB'

# collection of mbean server addresses
$jmx_addresses = 'localhost:1090', 'node01.my.domain:1090', 'node02.my.domain:1090'

# path to csv stats report file
$output_csv_file_path = '\path\to\ehcache_stats_report.csv'

# path to Jmxterm jar
$jmxterm_jar_path = '\path\to\jmxterm-1.0-alpha-4-uber.jar'

# and here it goes

$get_stats_command = 'get * -d net.sf.ehcache -b CacheManager={0},name={1},type=CacheStatistics'
$current_date = (Get-Date).ToString()

Foreach ($address in $jmx_addresses) {
  Foreach ($cache in $cache_names) {
    $command = $get_stats_command -f $cache_manager, $cache
    $stats = echo $command | java -jar $jmxterm_jar_path -l $address -n

    $stats = $stats | Select-String -Pattern "\w" | ForEach-Object { $_.line }

    $data = $stats | ForEach-Object { "$($_.Substring(2 + $_.LastIndexOf("="), $_.Length - 3 - $_.LastIndexOf("=")))" }
    $data = ($current_date,$address,$cache) + $data
    $csv = [string]::join(',', $data)

    $csv >> $output_csv_file_path
  }
}
