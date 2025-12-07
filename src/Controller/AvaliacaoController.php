<?php

namespace App\Controller;
use App\config\Database;
use App\Controller\LoginController;
use function App\src\connect;
session_start();

class AvaliacaoController
{
    public function avaliacao()
    {
        require __DIR__ . '/../../public/Avaliação/avaliacoes.html';
        $pdo = connect();
        if ($_SERVER["REQUEST_METHOD"] == "POST") {
            if (empty($_POST['adm_email']) || empty($_POST['adm_senha'])) {
                echo "por favor preencha todos os campos!";
            } else {
                $avalicao = filter_input(INPUT_POST, 'avaliaçao', FILTER_SANITIZE_SPECIAL_CHARS);
                $controller = new Database();

             }
        }
    }
}
