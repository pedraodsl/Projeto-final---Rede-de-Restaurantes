<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Bellor Restaurante | Site Oficial</title>
<link rel="stylesheet" href="cabecalho.css">
<link rel="stylesheet" href="Menu/menu.css">
<link rel="icon" type="image/png" href="Menu/img/Logo.titulo.png">
</head>
<body>
<header>
  <nav class="navbar">
   <a href="Home/index.html" class="logo">
      <img src="Menu/img/Logo.png" class="logo-tipo" alt="Logo Bellor">
    </a>

<ul class="nav-links" id="nav-links">
    <li><a href="/">Home</a></li>
    <li><a href="/reserva2">Reserva</a></li>
    <li><a href="/menu2">Menu</a></li>
    <li><a href="/projeto">Projeto</a></li>
    <li><a href="/avaliacao">Avaliacao</a></li>
    <li><a href="/sobre" >Sobre nós</a></li>
</ul>

    <div class="right-section">
     <a href="Pagina-login/login.html" class="login">
      <img src="Pagina-login/img/user.png" class="login" alt="Login">
      </a>
      <label class="switch">
        <input type="checkbox" id="modo-btn">
        <span class="slider"></span>
      </label>
      <button class="hamburger" id="hamburger">&#9776;</button>
    </div>
  </nav>
</header>

  <main>
    <section class="menu-section">
      <div class="menu-banner">
        <img src="Menu/img/Menu/peito-de-frango-grelhado-com-tomates-e-berinjela.png" alt="Prato principal">
      </div>

      <div class="menu-intro">
        <h1>MENU</h1>
        <hr>
        <p>Cada página deste menu é um convite ao prazer de comer bem — com calma, com desejo, com afeto.</p>
      </div>

      <!-- FILTRO -->
      <div class="menu-filter-container">
        <button class="filter-btn">Filtrar <span class="arrow">Down Arrow</span></button>
        <ul class="filter-options"></ul>
      </div>

      <!-- CATEGORIAS RÁPIDAS -->
      <div class="menu-categories" id="menu-categories"></div>

      <!-- TÍTULO DA CATEGORIA ATIVA -->
      <div class="current-category-title" id="current-category-title"></div>

      <!-- TODOS OS PRATOS -->
        <?php
        $pdo = \App\src\connect();
        $controller = new \App\config\Database();
        $menu_items = $controller -> buscar($pdo, "produto");
        ?>
        <!-- Envolva todos os itens do menu em um formulário principal, se quiser enviar tudo de uma vez -->
        <form action="/menu" method="POST">
            <?php foreach ($menu_items as $item): ?>
            <div class="menu-item-card">
                <img src="" alt="" class="item-image">
                <div class="item-details">
                    <h3 class="item-name"><?php echo htmlspecialchars($item['nome']); ?></h3>
                    <p class="item-description"></p>
                    <div class="item-footer">
                        <span class="item-price">R$ <?php echo number_format($item['preco'], 2, ',', '.'); ?></span>

                        <!-- Checkbox Oculto para Formulário -->
                        <input type="checkbox" id="item_<?php echo $item['id']; ?>" name="selected_items[]" value="<?php echo $item['id']; ?>" class="item-checkbox">

                        <!-- Botão que atua como label para o checkbox -->
                        <label for="item_<?php echo $item['id']; ?>" class="mark-button">Marcar Item</label>
                    </div>
                </div>
            </div>
            <?php endforeach; ?>

            <!-- Botão de envio principal, fora do loop -->
            <button type="submit" style="margin-top: 20px;">Enviar Pedido</button>
        </form>

        <style>
            /* Estilos do Card (adaptados do anterior) */
            .menu-item-card {
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                display: flex;
                margin-bottom: 20px;
                overflow: hidden;
                max-width: 600px;
                transition: transform 0.2s;
                border: 2px solid transparent; /* Adiciona uma borda transparente para destaque */
            }

            .menu-item-card.selected {
                border-color: #e44d26; /* Cor de destaque quando selecionado */
            }

            .item-image {
                width: 150px;
                height: 150px;
                object-fit: cover;
            }

            .item-details {
                padding: 15px;
                flex-grow: 1;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
            }

            .item-name {
                font-size: 1.2rem;
                font-weight: bold;
                color: #333;
                margin: 0 0 5px 0;
            }

            .item-description {
                font-size: 0.9rem;
                color: #666;
                margin: 0 0 10px 0;
            }

            .item-footer {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .item-price {
                font-size: 1.1rem;
                font-weight: bold;
                color: #e44d26;
            }

            /* Esconde o checkbox real */
            .item-checkbox {
                display: none;
            }

            /* Estilo do botão/label de marcar */
            .mark-button {
                background-color: #e44d26;
                color: white;
                border: none;
                padding: 8px 15px;
                border-radius: 4px;
                cursor: pointer;
                font-weight: bold;
                transition: background-color 0.2s, background-color 0.2s;
                display: inline-block; /* Para que a label se comporte como um botão */
            }

            .mark-button:hover {
                background-color: #ff6f41;
            }

            /* Estilo quando o item está marcado */
            .item-checkbox:checked + .mark-button {
                background-color: #4CAF50; /* Cor verde para indicar selecionado */
                content: "Item Marcado";
            }
        </style>

        <!-- Script JavaScript para alternar a classe 'selected' no card pai quando o checkbox é clicado -->
        <script>
            document.addEventListener('DOMContentLoaded', (event) => {
                document.querySelectorAll('.item-checkbox').forEach(checkbox => {
                    checkbox.addEventListener('change', function() {
                        const card = this.closest('.menu-item-card');
                        if (this.checked) {
                            card.classList.add('selected');
                            // Opcional: mudar o texto do botão instantaneamente via JS para feedback visual
                            this.nextElementSibling.textContent = 'Item Marcado';
                        } else {
                            card.classList.remove('selected');
                            this.nextElementSibling.textContent = 'Marcar Item';
                        }
                    });

                    // Define o estado inicial se já estiver marcado (ex: após erro de validação do form)
                    if (checkbox.checked) {
                        checkbox.closest('.menu-item-card').classList.add('selected');
                        checkbox.nextElementSibling.textContent = 'Item Marcado';
                    }
                });
            });
        </script>


        <!-- RESUMO DO PEDIDO -->
      <div class="pedido-container">
        <p class="valor-total">Valor total: <span id="total-value">R$ 0,00</span></p>
        <div class="botoes">
          <button class="botao">Pedir na mesa</button>
          <button class="botao">Pedir Delivery</button>
        </div>
      </div>
    </section>
  </main>

  <button id="scroll-up-btn" title="Voltar ao menu">Up Arrow</button>
  
    <!-- RODAPÉ -->
<footer class="footer">
  <div class="footer-container">
    <div class="footer-col">
      <a href="Home/index.html" class="footer-logo">
        <img src="Home/img/Logo grande.png" alt="Logo Bellor">
      </a>
      <p><a href="mailto:restaurantes@bellor.com.br">restaurantes@bellor.com.br</a></p>
      <p><a href="tel:+5577998793159">(77) 99879-3159</a></p>
      <div class="social-icons">
  <a href="https://www.instagram.com" target="_blank">
    <img src="img/logo-instagram.png" alt="Instagram">
  </a>
  <a href="https://x.com" target="_blank">
    <img src="img/logo-twitter.png" alt="Twitter">
  </a>
  <a href="https://www.facebook.com" target="_blank">
    <img src="img/logo-facebook.png" alt="Facebook">
  </a>
</div>
    </div>
    <div class="footer-col">
      <h4>Páginas</h4>
      <ul>
   <li><a href="Home/index.html">Home</a></li>
    <li><a href="Reservas/reservas.html">Reservas</a></li>
    <li><a href="Menu/menu.html">Menu</a></li>
    <li><a href="projeto/projeto.html">Projeto</a></li>
    <li><a href="Avaliação/avaliacoes.html">Avaliações</a></li>
    <li><a href="sobre-nos/sobre.html">Sobre nós</a></li>
      </ul>
    </div>
    <div class="footer-col">
      <h4>Localizações</h4>
      <ul>
        <li><a href="#">Guanambi - BA</a></li>
        <li><a href="#">Salvador - BA</a></li>
        <li><a href="#">Fortaleza - CE</a></li>
        <li><a href="#">São Paulo - SP</a></li>
        <li><a href="#">Rio de Janeiro - RJ</a></li>
        <li><a href="#">Belo Horizonte - MG</a></li>
      </ul>
    </div>
    <div class="footer-col">
      <h4>Atendimento</h4>
      <ul>
        <li><a href="Menu/menu.html">Faça seu pedido</a></li>
        <li><a href="Reservas/reservas.html">Faça sua reserva</a></li>
      </ul>
    </div>
  </div>

  <div class="footer-bottom">
    <p>© 2025 Bellor Restaurante. Todos os direitos reservados.</p>
  </div>
</footer>

  <script src="Menu/script.js"></script>
</body>
</html>