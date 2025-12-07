<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bellor | Promoções - Admin</title>
    <link rel="stylesheet" href="Pagina-adm/promocoes.css">
    <link rel="icon" type="image/png" href="Home/img/Logo.titulo.png">
</head>
<body>

<header class="navbar">
    <a href="Home/index.html" class="logo">
        <img src="Home/img/Logo.png" alt="Bellor">
    </a>

    <ul class="nav-links" id="nav-links">
        <li><a href="/doacoes">Doações</a></li>
        <li><a href="pratos.html">Cardápio</a></li>
        <li><a href="/rend_mensal_adm">Rendimento</a></li>
        <li><a href="votacao.html">Votação</a></li>
        <li><a href="/promocoes" class="active">Promoções</a></li>
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
        <h1>Gerenciar Promoções</h1>
        <p>Crie cupons para clientes normais ou exclusivos para quem doa</p>
    </section>

    <!-- FORMULÁRIO PARA CRIAR CUPOM -->
    <div class="form-container">
        <h2>Criar Novo Cupom</h2>
        <form id="form-cupom">
            <div class="form-grid">
                <input type="text" id="nome-cupom" placeholder="Nome do cupom (ex: Black Friday)" required>
                <input type="text" id="codigo-cupom" placeholder="Código (ex: BLACK20)" required style="text-transform:uppercase;">

                <div class="input-group">
                    <input type="number" id="desconto" placeholder="Desconto %" min="1" max="100" required>
                    <span>%</span>
                </div>

                <input type="date" id="validade" required>

                <select id="tipo-cupom">
                    <option value="normal">Cliente normal</option>
                    <option value="doacao" selected>Somente quem doou</option>
                </select>

                <button type="submit">Criar Cupom</button>
            </div>
        </form>
    </div>

    <!-- LISTA DE CUPONS -->
    <div class="cupons-container">
        <h2>Cupons Ativos (<span id="contador-cupons">0</span>)</h2>
        <div id="lista-cupons">
            <!-- Cupons carregados dinamicamente -->
        </div>
    </div>
</main>

<footer class="footer">
    <p>© 2025 Bellor Restaurante. Todos os direitos reservados.</p>
</footer>

<script src="Pagina-adm/promocoes.js"></script>
</body>
</html>