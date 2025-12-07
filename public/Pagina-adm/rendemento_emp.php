<?php
namespace App\Controller;

use App\config\Database;
use function App\src\connect;
use App\Controller\LoginController;

function show_data()
{
    $pdo = connect();
    $controller = new Database();
    $data = $controller -> grafico($pdo);
    if($data) {
        $val = $data;
    } else {
        $val = "0,00";
    }
    return $val;
}
?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bellor | Dashboard Financeiro</title>
    <link rel="stylesheet" href="Pagina-adm/rendimento.css">
    <link rel="icon" type="image/png" href="Home/img/Logo.titulo.png">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>

<!-- CABEÇALHO PADRONIZADO -->
<header class="navbar">
    <a href="Home/index.html" class="logo">
        <img src="Home/img/Logo.png" alt="Bellor">
    </a>

    <ul class="nav-links" id="nav-links">
        <li><a href="/doacoes">Doações</a></li>
        <li><a href="pratos.html">Cardápio</a></li>
        <li><a href="rendM.html" class="active">Rendimento</a></li>
        <li><a href="votacao.html">Votação</a></li>
        <li><a href="/promocoes">Promoções</a></li>
    </ul>

    <div class="right-section">
        <a href="Pagina-login/login.html"><img src="Pagina-login/img/user.png" alt="Perfil"></a>
        <label class="switch">
            <input type="checkbox" id="modo-btn">
            <span class="slider"></span>
        </label>
        <button class="hamburger" id="hamburger">Menu</button>
    </div>
</header>

<main class="dashboard">
    <div class="header">
        <h1>Dashboard Financeiro - Franquia Bellor</h1>
        <p class="subtitle">Acompanhe o crescimento da rede em tempo real</p>
    </div>

    <!-- CARDS DE RESUMO -->
    <div class="cards">
        <div class="card today">
            <div class="card-icon"><i class="fas fa-sun"></i></div>
            <div class="card-info">
                <h3>Vendas Hoje</h3>
                <p class="value">R$ <span id="hoje">0,00</span></p>
                <small id="hoje-comp">Carregando...</small>
            </div>
        </div>

        <div class="card week">
            <div class="card-icon"><i class="fas fa-calendar-week"></i></div>
            <div class="card-info">
                <h3>Esta Semana</h3>
                <p class="value">R$ <span id="semana">0,00</span></p>
                <small id="semana-comp">Carregando...</small>
            </div>
        </div>

        <div class="card month">
            <div class="card-icon"><i class="fas fa-calendar-month"></i></div>
            <div class="card-info">
                <h3>Este Mês</h3>
                <p class="value">R$ <span id="mes"><?php echo show_data(); ?></span></p>
                <small id="mes-comp">Carregando...</small>
            </div>
        </div>
    </div>

    <!-- GRÁFICO DE CRESCIMENTO -->
    <div class="chart-container">
        <h2>Crescimento da Receita da Franquia (2019–2025)</h2>
        <canvas id="growthChart"></canvas>
    </div>

    <div class="total-franquia">
        <h2>Total Acumulado da Franquia</h2>
        <p class="total-value">R$ <span id="total-acumulado"><?php echo show_data(); ?></span></p>
        <p class="crescimento-anual"><i class="fas fa-arrow-trend-up"></i> Crescimento desde 2019</p>
    </div>
</main>

<footer class="footer">
    <p>© 2025 Bellor Restaurante. Todos os direitos reservados.</p>
</footer>

<!-- Font Awesome para ícones -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/js/all.min.js"></script>
<script src="Pagina-adm/rendimento.js"></script>
</body>
</html>