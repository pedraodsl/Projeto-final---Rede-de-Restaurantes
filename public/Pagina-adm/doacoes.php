<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bellor | Doações - Admin</title>
    <link rel="stylesheet" href="Pagina-adm/doacoesAdm.css">
    <link rel="icon" type="image/png" href="Home/img/Logo.titulo.png">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>

<header class="navbar">
    <a href="Home/index.html" class="logo">
        <img src="Home/img/Logo.png" alt="Bellor">
    </a>

    <ul class="nav-links" id="nav-links">
        <li><a href="/doacoes" class="active">Doações</a></li>
        <li><a href="pratos.html">Cardápio</a></li>
        <li><a href="/rend_mensal_adm">Rendimento Mensal</a></li>
        <li><a href="votacao.html">Pratos Mais Votados</a></li>
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

<main>
    <section class="page-header">
        <h1>Histórico de Doações</h1>
        <p>Impacto social do Bellor em tempo real</p>
    </section>

    <div class="controls">
        <div class="period-selector">
            <button class="btn-period active" data-period="semana">Últimas 12 Semanas</button>
            <button class="btn-period" data-period="mes">Últimos 12 Meses</button>
        </div>

        <div class="date-filter">
            <label>Filtrar por dia:</label>
            <input type="date" id="data-filtro">
            <button id="btn-hoje">Hoje</button>
            <button id="btn-limpar">Limpar</button>
        </div>
    </div>

    <div class="chart-container">
        <canvas id="doacoesChart"></canvas>
    </div>

    <div class="table-container">
        <h2>Doações do dia: <span id="data-titulo">Carregando...</span></h2>
        <div class="total-dia">
            <strong>Total doado hoje: R$ <span id="total-dia">0,00</span></strong>
        </div>
        <table id="tabela-doacoes">
            <thead>
            <tr>
                <th>Hora</th>
                <th>Cliente</th>
                <th>Valor Doado</th>
            </tr>
            </thead>
            <tbody></tbody>
        </table>
    </div>
</main>

<footer class="footer">
    <p>© 2025 Bellor Restaurante. Todos os direitos reservados.</p>
</footer>

<script src="Pagina-adm/doacoesAdm.js"></script>
</body>
</html>