<?php

namespace App\Controller;
use App\config\Database;

class ReservaController
{
    public function reserva()
    {
        global $pdo;
        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            $email = $_POST['email'];
            $cpf = $_POST['cpf'];
            $nome = $_POST['nome'];
            $telefone = $_POST['telefone'];
            $tabela = "reserva";
            $salt = bin2hex(random_bytes(16));
            $h_email = hash('sha256', $salt . $email);
            $h_cpf = hash('sha256', $salt . $cpf);
            $h_nome = hash('sha256', $salt . $nome);
            $controller = new Database();
            $controller -> inserir_reserva($pdo, $tabela, $h_email, $h_cpf, $h_nome, $telefone);
        }
    }
}
?>