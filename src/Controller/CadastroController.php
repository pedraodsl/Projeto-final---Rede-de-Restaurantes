<?php

namespace App\Controller;

use App\config\Database;

class CadastroController
{

    function valida_cpf($cpf)
    {
        $cpf = preg_replace("/[^0-9]/", "", $cpf);
        if (strlen($cpf) != 11) {
            return false;
        }

        if (preg_match('/(\d)\1{10}/', $cpf)) {
            return false;
        }

        for ($t = 9; $t < 11; $t++) {
            for ($d = 0, $c = 0; $c < $t; $c++) {
                $d += $cpf[$c] * (($t + 1) - $c);
            }
            $d = ((10 * $d) % 11) % 10;
            if ($cpf[$c] != $d) {
                return false;
            }
        }
        return true;
    }
    public function cadastro()
    {

        if ($_SERVER["REQUEST_METHOD"] == "POST") {
            $salt = bin2hex(random_bytes(16));
            $cpf = $_POST["cpf"];
            if($this->valida_cpf($cpf) == true) {
                $cpf = hash('sha256', $salt . $cpf);
            }
            $senha = $_POST["senha"];
            $h_senha = hash('sha256', $salt . $senha);
            $nome = $_POST["nome"];
            $email = $_POST["email"];
            if (filter_var($email, FILTER_VALIDATE_EMAIL)) {
                $email = hash('sha256', $salt . $email);
            }
            $telefone = $_POST["telefone"];
            if (filter_var($telefone, FILTER_VALIDATE_REGEXP)) {
                $telefone = hash('sha256', $salt . $telefone);
            }
            $controller = new Database();
            $controller -> inserir_usuario($pdo, $cpf, $nome, $email, $telefone, $h_senha);
        }
    }
}
