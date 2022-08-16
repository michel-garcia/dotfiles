<?php
define("APPID", "");
define("LATITUDE", 0);
define("LONGITUDE", 0);
define("UNITS", "metric");

$url = join("?", [
    "https://api.openweathermap.org/data/2.5/weather",
    http_build_query([
        "appid" => APPID,
        "lat" => LATITUDE,
        "lon" => LONGITUDE,
        "units" => UNITS,
    ], "", "&")
]);

$data = file_get_contents($url);
if (empty($data)) {
    echo "Weather Unavailable";
    return;
}

$json = json_decode($data);
list($weather) = $json->weather;
$desc = ucwords($weather->description);
$temp = $json->main->feels_like;
switch (UNITS) {
    default:
    case "standard":
        $temp_unit = "K";
        break;
    case "metric":
        $temp_unit = "C";
        break;
    case "imperial":
        $temp_unit = "F";
        break;
}
echo "{$desc} {$temp}°{$temp_unit}";

