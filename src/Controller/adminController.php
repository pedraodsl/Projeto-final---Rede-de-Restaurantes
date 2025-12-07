<?php

namespace App\Controller;
use App\config\Database;
use App\controller\LoginController;
use function App\src\connect;
if(session_status() === PHP_SESSION_NONE) {
    session_start();
}

class adminController
{
    public function template()
    {
        require __DIR__ . '/../../public/Pagina-adm/admin (1).html';
    }

    public function admin()
    {
        $pdo = connect();
        $sec_control = new LoginController();
        $controller = new Database();
        $view = $controller->buscar_id($pdo, "administrador", "id_adm", $_SESSION["id_adm"]);
        $key = $controller -> buscar_chave($pdo, "chave_adm", $_SESSION["id_adm"], "id_adm");
        header('Content-Type: application/json');
        $dados = array(
            'nome' => $sec_control -> decript($view['nome'], $key['chave_criptografia']),
            'email' => $sec_control -> decript($view['email'], $key['chave_criptografia']),
            'telefone' => $sec_control -> decript($view['telefone'], $key['chave_criptografia']),
        );
        echo json_encode($dados);
    }

    public function restaurante()
    {
        $controller = new Database();
        $sec_control = new LoginController();
        $pdo = connect();
        $view2 = $controller->buscar_chave($pdo, "administrador", $_SESSION["id_adm"], "id_adm");
        $view3 = $controller->buscar_id($pdo, "restaurante", "id_restaurante", $view2['id_restaurante']);
        $key = $controller -> buscar_chave($pdo, "chave_adm", $_SESSION["id_adm"], "id_adm");
        header('Content-Type: application/json');
        $dados2 = array();
        foreach ($view3 as $restaurante) {
            $dados2[] = array(
                'endereco' => $sec_control -> decript($restaurante['endereco'], $key['chave_criptograia']),
                'status' => $sec_control -> decript($restaurante['status'], $key['chave_criptografia']),
                'horario' => $sec_control -> decript($restaurante['horario'], $key['chave_criptografia']),
            );
            echo json_encode($dados2);
        }
    }

    public function cardapio()
    {
        $controller = new Database();
        $sec_control = new LoginController();
        $pdo = connect();
        $view2 =  $controller->buscar_chave($pdo, "administrador", $_SESSION["id_adm"], "id_adm");
        $view_men = $controller->buscar_id($pdo, "vw_cardapio", "id_restaurante", $view2['id_restaurante']);
        $key = $controller -> buscar_chave($pdo, "chave_adm", $_SESSION["id_adm"], "id_adm");;
        header('Content-Type: application/json');
        $dados3 = array();
        foreach ($view_men as $cardapio) {
            $dados3[] = array(
                'nome' => $sec_control -> decript($cardapio['nome'], $key['chave_criptograia']),
                'preco' => $sec_control -> decript($cardapio['preco'], $key['chave_criptografia']),
            );
            echo json_encode($dados3);
        }
    }

    public function financeiro()
    {
                $controller = new Database();
                $pdo = connect();
                $view2 = $controller->buscar_chave($pdo, "administrador", $_SESSION["id_adm"], "id_adm");
                $view_fin = $controller -> buscar_id($pdo, "vw_financeiro_mensal_adm", "id_restaurante", $view2['id_restaurante']);
                header('Content-Type: application/json');
                $dados4 = array(
                    'total_mes' => $view_fin['total_recebido_mes'],
                );
                echo json_encode($dados4);
    }


    public function rend_mensal_adm()
    {
        $pdo = connect();
        require __DIR__. '/../../public/Pagina-adm/rendemento_emp.html';
        $controller = new Database();
        $fin_view = $controller -> buscar_id($pdo, "vw_financeiro_mensal_adm", "id_restaurante", $_SESSION["id_restaurante"]);
        header('Content-Type: application/json');
        $dados = array(
            'mensal' => $fin_view['total_recebido_mes'],
        );
        echo json_encode($dados);
    }
}