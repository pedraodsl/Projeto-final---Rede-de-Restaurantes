<?php


require __DIR__ . '/../vendor/autoload.php';


$routes = require_once __DIR__ . '/../src/Routes/web.php';

$uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

$requestMethod = $_SERVER['REQUEST_METHOD'];

$routeFound = false;

foreach ($routes as $route) {
    list($method, $path, $callback ) = $route;

    if ($method === $requestMethod && $path === $uri) {
        $callback();
        $routeFound = true;
        break;
    }
}

if (!$routeFound) {
    http_response_code(404);
    echo "<h1>404 Not Found</h1>";
}