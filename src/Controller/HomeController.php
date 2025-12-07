<?php


namespace App\Controller;
use App\config\Database;
use function App\src\connect;
session_start();

 class HomeController
{
    public function home()
    {
        $pdo = connect();
        require __DIR__ . '/../../public/Home/index.html';
    }
}

