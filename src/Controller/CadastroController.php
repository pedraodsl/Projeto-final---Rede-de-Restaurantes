<?php

namespace App\Controller;

use App\config\Database;
use function App\src\connect;
use App\Controller\LoginController;
session_start();

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

        $controller = new LoginController();
        $pdo = connect();
        if ($_SERVER["REQUEST_METHOD"] == "POST") {
            if (empty($_POST['cpf']) || empty($_POST['nome']) || empty($_POST['senha'])) {
                #$url_atual = $_SERVER['REQUEST_URI'];
                header("Location: /cadastro2");
                #echo "por favor preencha todos os campos!";
            } else {
                $cpf = filter_input(INPUT_POST, "cpf", FILTER_SANITIZE_SPECIAL_CHARS);
                if ($this->valida_cpf($cpf) == true) {
                    $h_cpf = password_hash($cpf, PASSWORD_DEFAULT);
                } else {
                    #$url_atual = $_SERVER['REQUEST_URI'];
                    header("Location: /cadastro2");
                    #echo "cpf invalido";
                    exit();
                }
                $key = $controller -> gen_key();
                $senha = filter_input(INPUT_POST, "senha", FILTER_SANITIZE_SPECIAL_CHARS);
                $h_senha = password_hash($senha, PASSWORD_DEFAULT);
                $nome = filter_input(INPUT_POST, "nome", FILTER_SANITIZE_SPECIAL_CHARS);
                $h_nome = $controller -> cripto($nome, $key);
                $controller_data = new Database();
                $val = $controller_data -> buscar($pdo, "cliente");
                $find_user = true;
                foreach ($val as $campo) {
                    if ($campo["cpf"] == $cpf && $campo["senha_hash"] == $h_senha) {
                        #$url_atual = $_SERVER['REQUEST_URI'];
                        #header("Location: $url_atual");
                        #echo "dados invalidos tente novamente";
                        $find_user = false;
                    }
                }
                if ($find_user == true) {
                    $controller_data -> key_transaction($pdo, $cpf, $h_nome, $h_senha, $key);
                    #echo "cadastro realizado com sucesso!";
                    $user = $controller_data -> buscar_id($pdo, "cliente", "id_cliente", $cpf);
                    $user_table = "usuario_chave";
                    $session_key = $controller_data -> buscar_chave($pdo, $user_table, $cpf, "cpf");
                    $_SESSION['cpf'] = $cpf;
                    $_SESSION['email'] = $user['email'];
                    $_SESSION['nome'] = $user['nome'];
                    header('Location: /');
                    exit();
                }
            }
        }
    }

    public function adm_cadastro()
    {
       $controller = new LoginController();
       $pdo = connect();
       $key = $controller -> gen_key();
       if ($_SERVER["REQUEST_METHOD"] == "POST") {
           if (empty($_POST['cpf-admin']) && empty($_POST['nome-admin']) && empty($_POST['senha-admin']) && empty($_POST['restaurante']) || empty($_POST['email']) && empty($_POST['codigo']) && empty($_POST['cidade'])) {
               header('Location: /menu2');
           } else {
               $cpf = filter_input(INPUT_POST, "cpf-admin", FILTER_SANITIZE_SPECIAL_CHARS);
               if($this->valida_cpf($cpf) == true){
                   $h_cpf = password_hash($cpf, PASSWORD_DEFAULT);
               } else {
                   header('Location: /cadastro2');
               }
               $nome = filter_input(INPUT_POST, "nome-admin", FILTER_SANITIZE_SPECIAL_CHARS);
               $codigo = filter_input(INPUT_POST, "codigo", FILTER_SANITIZE_SPECIAL_CHARS);
               $cidade = filter_input(INPUT_POST, "cidade", FILTER_SANITIZE_SPECIAL_CHARS);
               $nome_rest = filter_input(INPUT_POST, "restaurante", FILTER_SANITIZE_SPECIAL_CHARS);
               $email = filter_input(INPUT_POST, "email", FILTER_SANITIZE_SPECIAL_CHARS);
               if (filter_var($email, FILTER_VALIDATE_EMAIL)) {
                   $h_email = $controller -> cripto($email, $key);
               } else {
                   header('Location: /cadastro2');
               }
               $senha = $_POST["senha-admin"];
               $h_senha = password_hash($senha, PASSWORD_DEFAULT);
               $h_nome = $controller -> cripto($nome, $key);
               $h_nome_rest  = $controller -> cripto($nome_rest, $key);
               $h_cidade = $controller -> cripto($cidade, $key);
               $cod_rest = $controller -> cripto($codigo, $key);
               $data_controll = new Database();
               $validate = $data_controll -> buscar($pdo, "administrador");
               $find_user = true;
               foreach ($validate as $campo) {
                   if($campo["cpf"] == $h_cpf && $campo["senha"] == $h_senha){
                       #header('Location: /');
                       $find_user = false;
                   }
               }
               if ($find_user == true) {
                   $data_controll -> transaction($pdo, $h_nome_rest, $cod_rest, $cpf, $h_email, $h_senha, $h_cidade, $h_nome, $key);
                   #echo "cadastro realizado com sucesso!";
                   $user = $data_controll -> buscar_id($pdo, "administrador", "cpf", $cpf);
                   $session_key = $data_controll -> buscar_chave($pdo, "chave_adm", $user["id_adm"], "id_adm");
                   $_SESSION['id_admin'] =  $nome;
                   $_SESSION['id_rest'] =  $user['id_restaurante'];
                   $_SESSION['nome-admin'] = $user['nome'];
                   header('Location: /admin2');
                   exit;
               }
           }
       }
    }
}
