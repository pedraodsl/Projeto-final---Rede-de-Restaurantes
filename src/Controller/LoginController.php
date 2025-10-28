<?php

namespace App\Controller;
use App\config\Database;

class LoginController
{
    public function login()
    {
        global $pdo;
        if ($_SERVER["REQUEST_METHOD"] == "GET") {
            $email = $_GET["email"];
            $senha = $_GET["senha"];
            $tabela = "usuarios";
            $salt = bin2hex(random_bytes(16));
            $h_senha = hash('sha256', $salt . $senha);
            $h_email = hash('sha256', $salt . $email);
            $controller = new Database();
            $controller -> login($pdo, $tabela, $h_email, $h_senha);
        }
    }
}
?>