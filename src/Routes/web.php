<?php

namespace App\src\Routes;


use App\Controller\adminController;
use App\Controller\adminController2;
use App\Controller\AvaliacaoController;
use App\Controller\HomeController;
use App\Controller\LoginController;
use App\Controller\pratoController;
use App\Controller\projetoController;
use App\Controller\ReservaController;
use App\Controller\MenuController;
use App\Controller\CadastroController;
use App\Controller\sobreController;
use App\Controller\frontloginController;



return [
    ['GET', '/', function () {
    $controller = new HomeController();
    $controller -> home();
    }],

    ['POST', '/login', function () {
    $controller = new LoginController();
    $controller -> login();
    $controller -> log_adm();
    }],

    ['POST', '/menu', function () {
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
    $controller ->adm_cadastro();
    }],

    ['GET', '/admin' , function () {
    $controller = new adminController();
    $controller -> template();
    $controller -> admin();
    $controller -> rend_mensal_adm();
    $controller -> restaurante();
    $controller -> cardapio();
    $controller -> financeiro();
    }],

    ['GET', '/projeto', function () {
    $controller = new projetoController();
    $controller -> projeto();
    }],

    ['GET', '/sobre', function () {
    $controller = new sobreController();
    $controller -> sobre();
    }],

    ['GET', '/avaliacao', function () {
    $controller = new AvaliacaoController();
    $controller -> avaliacao();
    }],

    ['POST', '/novo_prato', function () {
    $controller = new PratoController();
    $controller -> handle_add_dish_form();
    }],

    ['GET', '/admin2', function () {
    $controller = new adminController2();
    $controller -> admin();
    $controller -> pratos();
    }],

    ['GET', '/login2', function () {
    require __DIR__ . "/../Controller/login.php";
    }],

    ['GET', '/cadastro2', function () {
    require __DIR__ . "/../Controller/cadastre.php";
    }],

    ['GET', '/reserva2', function () {
    require __DIR__ . "/../Controller/reservas.php";
    }],

    ['POST', '/novo_prato2', function () {
    require __DIR__ . "/../Controller/prato.php";
    }],

    ['GET', '/menu2', function () {
    require __DIR__ . "/../Controller/menu.php";
    }],

    ['GET', '/doacoes', function () {
    require __DIR__ . "/../../public/Pagina-adm/doacoes.php";
    }],

    ['GET', '/rend_mensal_adm', function () {
    require __DIR__ . "/../../public/Pagina-adm/rendemento_emp.php";
    }],

    ['GET', '/promocoes', function () {
    require __DIR__ . "/../../public/Pagina-adm/promocoes.php";
    }]
];