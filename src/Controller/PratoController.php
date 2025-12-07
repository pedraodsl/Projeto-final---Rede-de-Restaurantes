<?php

namespace App\Controller;
use App\config\Database;
use function App\src\connect;
session_start();

class PratoController
{


       public function handle_add_dish_form()
       {

           var_dump($_POST);
           $pdo = connect();
           if ($_SERVER["REQUEST_METHOD"] == "POST") {
               if (empty($_POST['nome_prato']) || empty($_POST['preco'])) {
                   echo "Preencha todos os campos!";
               }else {
                   $nome = $_POST['nome_prato'];
                   $preco = $_POST['preco'];
                   // Chamar a função de inserção no banco de dados
                   $controller = new Database();
                   $prato = $controller->insert_prato($pdo, $_SESSION['id_restaurante'], $_SESSION['id_adm'], $nome, $preco);
                   if ($prato == true) {
                       header('Location: /admin2');
                   }
               }
           }
       }
}
