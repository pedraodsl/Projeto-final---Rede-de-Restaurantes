<?php

namespace App\Controller;
use App\config\Database;
use App\Controller\LoginController;
use function App\src\connect;
session_start();

class MenuController
{
    public function menu()
    {
        $pdo = connect();
        $sec = new LoginController();

// Define o local de redirecionamento em caso de acesso direto indevido


// Verifica se a requisição foi feita usando post
        if ($_SERVER["REQUEST_METHOD"] == "POST") {
            // Verifica se o array de itens selecionados existe e não está vazio
            if (isset($_POST['selected_items[]']) && !empty($_POST['selected_items[]'])) {
                // Atribui o array de IDs dos itens selecionados a uma variável
                $itens_selecionados_ids = $_POST['selected_items'];


                $controller = new Database();
                foreach ($itens_selecionados_ids as $item_id) {
                      $controller -> inserir_compra($pdo, $item_id['valor_total']);
                }


            } else {
                header("Location: /menu2");
            }
        } else {
            // Se não for uma requisição POST, redireciona o usuário para a página inicial
            header("Location: /menu2");
            exit();
        }


    }
}

