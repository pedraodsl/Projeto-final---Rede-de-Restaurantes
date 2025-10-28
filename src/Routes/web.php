<?php

use App\Controller\LoginController;
use App\Controller\ReservaController;
use App\Controller\MenuController;
use App\Controller\CadastroController;

return [
    ['GET', '/', function () {
    $controller = new HomeController();
    $controller -> home();
    }],

    ['POST', '/login', function () {
    $controller = new LoginController();
    $controller -> login();
    }],

    ['GET', '/menu', function () {
    $controller = new MenuController();
    $controller -> menu();
    }],

    ['POST', '/reserva', function () {
    $controller = new ReservaController();
    $controller -> reserva();
    }],

    ['POST', '/cadastro', function () {
    $controller = new CadastroController();
    $controller -> cadastro();
    }]
];
?>