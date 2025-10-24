<?php

use BELLOS_backend\src\Controller\ApiController;

return [
    ['GET', '/', function () {
    $controller = new HomeController();
    $controller -> index();
    }]
];
?>