<?php

namespace App\Controller;

use App\config\Database;

class CadastroController
{
    public function cadastro()
    {
        global $pdo;
        if ($_SERVER["REQUEST_METHOD"] == "POST") {
            $cpf = $_POST["cpf"];
            $senha = $_POST["senha"];
            $nome = $_POST["nome"];
            $email = $_POST["email"];
            $telefone = $_POST["telefone"];
            $salt = bin2hex(random_bytes(16));
            $h_senha = hash("sha256", $salt . $senha);
            $h_cpf = hash("sha256", $salt . $cpf);
            $h_email = hash("sha256", $salt . $email);
            $controller = new Database();
            $controller -> inserir_usuario($pdo, $h_cpf, $nome, $h_email, $telefone, $h_senha);
        }
    }
}
