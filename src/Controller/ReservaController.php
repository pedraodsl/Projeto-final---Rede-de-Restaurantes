<?php

namespace App\Controller;
use App\config\Database;
use App\Controller\LoginController;
use App\Controller\CadastroController;
use DateTime;
use function App\src\connect;



class ReservaController
{
    public function reserva()
    {


        $controller = new LoginController();
        $cpf_val = new CadastroController();
        $data = new Database();
        $pdo = connect();
        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            if (empty($_POST['nome']) || empty($_POST['email']) || empty($_POST['telefone'])) {
                $url_atual = $_SERVER['REQUEST_URI'];
                #header("Location: $url_atual");
                #echo "por favor preencha todos os campos!";
            } else {
                $email = filter_input(INPUT_POST, "email", FILTER_SANITIZE_SPECIAL_CHARS);
                $nome = filter_input(INPUT_POST, "nome", FILTER_SANITIZE_SPECIAL_CHARS);
                $telefone = filter_input(INPUT_POST, "telefone", FILTER_SANITIZE_SPECIAL_CHARS);
                $log = new LoginController();
                $key = $log -> gen_key();
                $h_email = $log -> cripto($email, $key);
                $h_telefone = $log -> cripto($telefone, $key);
                $h_nome = $log -> cripto($nome, $key);
                $data = $_POST['data'];
                $hora = $_POST['hora'];
                $tabela = "agendamento";
                $controller = new Database();
                $controller->inserir_reserva($pdo, $tabela, $email, $nome, $telefone, $data, $hora);
                header('Location: /menu2');
            }
        }
    }
}
