<?php

namespace App\Controller;
use App\config\Database;
use App\controller\LoginController;
use function App\src\connect;
session_start();

// Desativa a exibição de erros na tela
ini_set('display_errors', 0);

// Define qual nível de erro reportar (E_ALL reporta todos, mas não serão exibidos)
ini_set('error_reporting', E_ALL);

// Opcional: Garante que os erros não sejam exibidos de forma alguma
error_reporting(0);


class adminController2
{
   public function admin()
   {

        if ((!isset($_SESSION['id_adm']) == true) and (!isset($_SESSION['id_restaurante']) == true))
        {
            unset($_SESSION['id_adm']);
            unset($_SESSION['id_restaurante']);
            header('Location: LoginController.php');
        }

       $pdo = connect();
       $sec_control = new LoginController();
       $controller = new Database();
       $view = $controller->buscar_id($pdo, "administrador", "id_adm", $_SESSION["id_adm"]);
       $key = $controller -> buscar_chave($pdo, "chave_adm", $_SESSION["id_adm"], "id_adm");
       $info_pess = array(
           "nome" => $sec_control -> decript($view['nome'], $key['chave_criptografia']),
           "email" => $sec_control -> decript($view['email'], $key['chave_criptografia']),
       );
       return $info_pess;
   }

   public function pratos()
   {
       $pdo = connect();
       $controller = new Database();
       $sec_control = new LoginController();
       $view2 =  $controller->buscar_chave($pdo, "administrador", $_SESSION["id_adm"], "id_adm");
       $view_men = $controller->buscar_id($pdo, "produto", "id_administrador", $_SESSION["id_adm"]);
       $key = $controller -> buscar_chave($pdo, "chave_adm", $_SESSION["id_adm"], "id_adm");
       $p_array = array(
               "nome" => $view2["nome"],
               #"preco" => $view2["preco"],
       );
       return $p_array;
   }

   public function nov_cli()
   {
       $pdo = connect();
       $controller = new Database();
       $new = $controller -> clientes($pdo);
       return $new;
   }
}
?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Bellor | Painel Administrativo</title>
    <link rel="stylesheet" href="Pagina-adm/cabecalho.css"/>
    <link rel="stylesheet" href="Pagina-adm/admin.css"/>
    <link rel="icon" type="image/png" href="Pagina-adm/img/Logo.titulo.png"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet"/>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .loading { opacity: 0.6; pointer-events: none; }
        .modal { position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.7); display: flex; align-items: center; justify-content: center; z-index: 9999; }
        .modal-content { background: white; padding: 2rem; border-radius: 12px; width: 90%; max-width: 500px; }
        .modal-content label { display: block; margin: 1rem 0; }
        .modal-content input, .modal-content select { width: 100%; padding: 0.8rem; border: 1px solid #ccc; border-radius: 6px; }
        .btn-small { padding: 0.4rem 0.8rem; font-size: 0.9rem; }
        .status.on { color: green; font-weight: bold; }
        .status.off { color: red; font-weight: bold; }
    </style>
</head>
<body>

<!-- HEADER (mantido igual) -->
<header>
    <nav class="navbar">
        <a href="Home/index.html" class="logo"><img src="Home/img/Logo.png" class="logo-tipo" alt="Bellor"></a>
        <ul class="nav-links" id="nav-links">
            <li><a	href="Pagina-adm/doações.html">Doações</a></li>
            <li><a href="Pagina-adm/pratos.html">Cardápio</a></li>
            <li><a href="/rend_mensal_adm">Rendimento</a></li>
            <li><a href="Pagina/adm/votação.html">Votação</a></li>
            <li><a href="Pagina-adm/promoções.html">Promoções</a></li>
            <li><a href="Pagina-adm/admin-reservas.html">Reservas</a></li>
        </ul>
        <div class="right-section">
            <a href="Pagina-login/login.html"><img src="Pagina-login/img/user.png" class="login" alt="Login"></a>
            <label class="switch"><input type="checkbox" id="modo-btn"><span class="slider"></span></label>
            <button class="hamburger" id="hamburger">Menu</button>
        </div>
    </nav>
</header>

<div class="dashboard-container">
    <aside class="sidebar">
        <div class="sidebar-header">
            <a href="#perfil" class="home-link">
                <img src="Pagina-adm/img/Logo.png" alt="Bellor" class="sidebar-logo">
                <h2>Administração</h2>
            </a>
        </div>
        <nav class="sidebar-nav">
            <ul>
                <li><a href="#perfil" class="active"><i class="fas fa-user"></i> Perfil & Conta</a></li>
                <li><a href="#restaurantes"><i class="fas fa-store"></i> Restaurantes</a></li>
                <li><a href="#cardapio"><i class="fas fa-utensils"></i> Cardápio</a></li>
                <li><a href="#equipe"><i class="fas fa-users"></i> Equipe</a></li>
                <li><a href="#estoque"><i class="fas fa-box"></i> Estoque</a></li>
                <li><a href="#relatorios"><i class="fas fa-chart-bar"></i> Relatórios</a></li>
            </ul>
        </nav>
        <div class="sidebar-footer">
            <button id="logout-btn"><i class="fas fa-sign-out-alt"></i> Sair</button>
        </div>
    </aside>

    <main class="main-content">

        <!-- PERFIL -->
        <section id="perfil" class="section active">
            <h1><i class="fas fa-user"></i> Perfil & Conta</h1>
            <div class="grid-2">
                <div class="card">
                    <?php
                       $controller2 = new AdminController2();
                       $assoc = $controller2 -> admin();
                     ?>
                    <h3>Informações Pessoais</h3>
                    <p><strong>Nome:</strong> <p> <?php echo $assoc['nome']; ?></p>
                    <p><strong>E-mail:</strong> <p> <?php echo $assoc['email']; ?> </p>
                    <p><strong>Telefone:</strong> <span id="campo-telefone">-</span></p>
                    <p><strong>Idioma:</strong> <span id="campo-idioma">Português (BR)</span></p>
                    <button class="btn-edit" id="btn-editar-perfil">Editar Perfil</button>
                </div>
                <div class="card">
                    <h3>Segurança</h3>
                    <p>2FA: <span id="campo-2fa" class="status off">Desativado</span></p>
                    <p>Último login: <span id="campo-ultimo-login">-</span></p>
                </div>
            </div>
        </section>

        <!-- RESTAURANTES -->
        <section id="restaurantes" class="section">
            <h1><i class="fas fa-store"></i> Gestão de Restaurantes</h1>
            <button class="btn-primary" id="btn-nova-unidade">+ Adicionar Unidade</button>
            <div id="lista-restaurantes" class="restaurante-list">
                <!-- carregado via JS -->
            </div>
        </section>

        <!-- CARDÁPIO -->
        <section id="cardapio" class="section">
            <h1><i class="fas fa-utensils"></i> Cardápio</h1>
            <form action="/novo_prato2" method="POST">
                <button class="btn-primary" id="btn-novo-prato">+ Novo Prato</button>
            </form>
            <table class="table">
                <thead>
                <tr>
                    <th>Prato</th>
                    <th>Preço</th>
                    <th>Categoria</th>
                    <th>Status</th>
                    <th>Ações</th>
                    <th>. . .</th>
                </tr>
                </thead>
                <tbody>
                <?php
                    $lista_pratos = new  adminController2();
                    $array_pratos = $lista_pratos -> pratos();
                    $_size = count($array_pratos);
                    $i = 0;
                    while($i <= $_size) {
                        if(is_array($array_pratos) && !empty($array_pratos)) {
                            echo "<tr>";
                            #echo "<td>" . $array_pratos['preco'] . "</td>";
                            echo "<td>" . $array_pratos['nome'] . "</td>";
                            $i ++;
                        } else {
                            echo "<tr>";
                            echo "<td>" . "--" . "</td>";
                            echo "<td>" . "--" . "</td>";
                        }
                    }
                ?>
                </tbody>
            </table>
        </section>

        <!-- RELATÓRIOS (mantido com gráficos dinâmicos) -->
        <section id="relatorios" class="section">
            <h1><i class="fas fa-chart-bar"></i> Relatórios</h1>
            <div class="stats-grid">
                <?php
                $controller = new AdminController2();
                $pdo = connect();
                $data = new Database();
                $dfin = $data -> grafico($pdo);
                $person = $controller -> nov_cli();
                ?>
                <div class="stat-card big"><div class="stat-icon">R$</div><div class="stat-value" id="vendas-hoje"><?php echo $dfin; ?></div><div class="stat-label">Vendas Hoje</div></div>
                <div class="stat-card big"><div class="stat-icon">Person</div><div class="stat-value" id="novos-clientes"><?php echo $person; ?></div><div class="stat-label">Novos Clientes</div></div>
            </div>
            <div class="chart-container" style="height: 400px;">
                <canvas id="grafico-vendas"></canvas>
            </div>
        </section>

    </main>
</div>

<script src="Pagina-adm/script.js"></script>
</body>
</html>