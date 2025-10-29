<?php

namespace App\Controller;
use App\config\Database;

class LoginController
{
    public function login()
    {

        if ($_SERVER["REQUEST_METHOD"] == "POST") {
            require __DIR__ . "/templates/index.html";
            $email = $_POST["email"];
            $senha = $_POST["senha"];
            $tabela = "usuarios";
            $salt = bin2hex(random_bytes(16));
            $h_senha = hash('sha256', $salt . $senha);
            $h_email = hash('sha256', $salt . $email);
            $controller = new Database();
            $controller -> Login($pdo, $tabela, $h_email, $h_senha);
        }
    }
}
?>