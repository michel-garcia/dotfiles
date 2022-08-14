<?php
define("CITY", "Miami");
define("LATITUDE", 25.75);
define("LONGITUDE", -80.25);
define("TEMPERATURE_UNIT", "celsius");
define("TIMEZONE", "EST");
$url = join("?", [
    "https://api.open-meteo.com/v1/forecast",
    http_build_query([
        "current_weather" => "true",
        "latitude" => LATITUDE,
        "longitude" => LONGITUDE,
        "temperature_unit" => TEMPERATURE_UNIT,
        "timezone" => TIMEZONE
    ], "", "&")
]);
$contents = file_get_contents($url);
if (empty($contents)) {
    printf("󰅤");
    return;
}
$json = json_decode($contents);
if (property_exists($json, "error") && $json->error) {
    printf($json->reason);
    return;
}
$codes = array(
    0 => array(
        "label" => "Clear",
        "day" => "󰖙",
        "night" => "󰖔"
    ),
    1 => array(
        "label" => "Mainly Clear",
        "day" => "󰖙",
        "night" => "󰖔"
    ),
    2 => array(
        "label" => "Partly Cloudy",
        "day" => "󰖕",
        "night" => "󰼱"
    ), 
    3 => array(
        "label" => "Overcast",
        "day" => "󰖐",
        "night" => "󰖐"
    ),
    45 => array(
        "label" => "Fog",
        "day" => "󰖑",
        "night" => "󰖑"
    ),
    48 => array(
        "label" => "Depositing Rime Fog",
        "day" => "󰖑",
        "night" => "󰖑"
    ),
    51 => array(
        "label" => "Light Drizzle",
        "day" => "󰖗",
        "night" => "󰖗"
    ),
    53 => array(
        "label" => "Moderate Drizzle",
        "day" => "󰖗",
        "night" => "󰖗"
    ),
    55 => array(
        "label" => "Dense Drizzle",
        "day" => "󰖗",
        "night" => "󰖗"
    ),
    56 => array(
        "label" => "Light Freezing Drizzle",
        "day" => "󰖗",
        "night" => "󰖗"
    ),
    57 => array(
        "label" => "Dense Freezing Drizzle",
        "day" => "󰖗",
        "night" => "󰖗"
    ),
    61 => array(
        "label" => "Slight Rain",
        "day" => "󰖗",
        "night" => "󰖗"
    ),
    63 => array(
        "label" => "Moderate Rain",
        "day" => "󰖖",
        "night" => "󰖖"
    ),
    65 => array(
        "label" => "Heavy Rain",
        "day" => "󰖖",
        "night" => "󰖖"
    ),
    66 => array(
        "label" => "Light Freezing Rain",
        "day" => "󰖗",
        "night" => "󰖗"
    ),
    67 => array(
        "label" => "Heavy Freezing Rain",
        "day" => "󰖖",
        "night" => "󰖖"
    ),
    71 => array(
        "label" => "Slight Snow",
        "day" => "󰖘",
        "night" => "󰖘"
    ),
    73 => array(
        "label" => "Moderate Snow",
        "day" => "󰼶",
        "night" => "󰼶"
    ),
    75 => array(
        "label" => "Heavy Snow",
        "day" => "󰼶",
        "night" => "󰼶"
    ),
    77 => array(
        "label" => "Snow Grains",
        "day" => "󰖘",
        "night" => "󰖘"
    ),
    80 => array(
        "label" => "Slight Rain Showers",
        "day" => "󰖗",
        "night" => "󰖗"
    ),
    81 => array(
        "label" => "Moderate Rain Showers",
        "day" => "󰖖",
        "night" => "󰖖"
    ),
    82 => array(
        "label" => "Heavy Rain Showers",
        "day" => "󰖖",
        "night" => "󰖖"
    ),
    85 => array(
        "label" => "Slight Snow Showers",
        "day" => "󰖘",
        "night" => "󰖘"
    ),
    86 => array(
        "label" => "Heavy Snow Showers",
        "day" => "󰼶",
        "night" => "󰼶"
    )
);
$temperature_units = array(
    "celsius" => "C",
    "fahrenheit" => "F"
);
list("current_weather" => $current_weather) = get_object_vars($json);
$code = (object) $codes[$current_weather->weathercode] ?? null;
$components = array(
    "city" => CITY,
    "weather_icon" => date("H") <= 18 ? $code?->day : $code?->night,
    "weather_label" => $code?->label,
    "temp" => $current_weather->temperature,
    "temp_unit" => $temperature_units[TEMPERATURE_UNIT]
);
printf(
    "%s %s %s°%s",
    $components["weather_icon"],
    $components["weather_label"],
    $components["temp"],
    $components["temp_unit"]
);

