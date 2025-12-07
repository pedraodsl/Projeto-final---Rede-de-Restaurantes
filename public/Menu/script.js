// ===== DADOS DOS PRATOS =====
const pratos = [];

// ELEMENTOS
const dishesContainer    = document.getElementById("dishes-container");
const menuCategories     = document.getElementById("menu-categories");
const filterBtn          = document.querySelector(".filter-btn");
const filterOptions      = document.querySelector(".filter-options");
const totalValueSpan     = document.getElementById("total-value");
const currentTitle       = document.getElementById("current-category-title");

let carrinho = {};

// FUNÇÕES AUXILIARES
const formatarPreco = p => p.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
const stars = n => "★".repeat(n) + "☆".repeat(5-n);

const meuNovoPrato = {
   id:10,
   nome: "Lasanha",
   preco: 15.00,
   precoPromo: null,
   categoria: " ",
   img: "prato_la.jpg",
   rating: 4,
   vegan: false,
   álcool: false,
   tempo: " "
};

const criarPrato = p => {
  const div = document.createElement("div");
  div.className = "dish";
  div.dataset.categoria = p.categoria;
  div.innerHTML = `
    <div class="dish-img" style="background-image:url('img/Menu/${p.img}');"></div>
    <div class="dish-text">
      <h4>${p.nome}</h4>
      <div class="rating">${stars(p.rating)}</div>
      <div class="dish-footer">
        <div class="price-time">
          ${p.precoPromo ? `<span class="old-price">${formatarPreco(p.preco)}</span>` : ''}
          <span class="price ${p.precoPromo?'new-price':''}">${formatarPreco(p.precoPromo || p.preco)}</span>
          ${p.vegan ? '<span class="vegan-label">Vegano</span>' : ''}
          ${p.alcool ? '<span class="alcohol-label">Contém Álcool</span>' : ''}
          <span class="prep-time">⏱ ${p.tempo} min</span>
        </div>
        <div class="quantity-selector" data-id="${p.id}">
          <button class="minus">-</button>
          <span class="quantity">0</span>
          <button class="plus">+</button>
        </div>
      </div>
    </div>
  `;
  return div;
};

const elementosDoPrato = criarPrato(meuNovoPrato);

// RENDER
const renderPratos = (filtro = "todos") => {
  dishesContainer.innerHTML = "";
  if (filtro === "todos") {
    currentTitle.classList.remove("show");
  } else {
    const cat = categorias.find(c => c.id === filtro);
    currentTitle.textContent = cat ? cat.nome.toUpperCase() : "";
    currentTitle.classList.add("show");
  }
  const lista = filtro === "todos" ? pratos : pratos.filter(p => p.categoria === filtro);
  lista.forEach(p => dishesContainer.appendChild(criarPrato(p)));

  // Scroll suave
  window.scrollTo({ top: filtro === "todos" ? 0 : currentTitle.offsetTop - 120, behavior: "smooth" });
  atualizarTotal();
};

const renderCategorias = () => {
  menuCategories.innerHTML = "";
  categorias.forEach(cat => {
    const el = document.createElement("div");
    el.className = "category";
    el.innerHTML = `<div class="img-placeholder" style="background-image:url('img/Menu/${cat.id}.jpg');"></div><p>${cat.nome}</p>`;
    el.onclick = () => {
      renderPratos(cat.id);
      filterBtn.firstElementChild.textContent = cat.nome + " ";
    };
    menuCategories.appendChild(el);
  });
};

const renderFiltro = () => {
  filterOptions.innerHTML = `<li data-target="todos">Todos os pratos</li>`;
  categorias.forEach(cat => {
    const li = document.createElement("li");
    li.textContent = cat.nome;
    li.dataset.target = cat.id;
    filterOptions.appendChild(li);
  });
};

// EVENTOS
filterBtn.addEventListener("click", () => {
  filterOptions.classList.toggle("show");
  filterBtn.classList.toggle("open");
});

filterOptions.addEventListener("click", e => {
  if (e.target.tagName === "LI") {
    const id = e.target.dataset.target;
    filterBtn.firstElementChild.textContent = id === "todos" ? "Filtrar " : e.target.textContent + " ";
    filterOptions.classList.remove("show");
    filterBtn.classList.remove("open");
    renderPratos(id);
  }
});

dishesContainer.addEventListener("click", e => {
  const sel = e.target.closest(".quantity-selector");
  if (!sel) return;
  const id = Number(sel.dataset.id);
  const qtd = sel.querySelector(".quantity");
  let valor = Number(qtd.textContent);
  if (e.target.classList.contains("plus")) valor++;
  if (e.target.classList.contains("minus") && valor > 0) valor--;
  qtd.textContent = valor;
  if (valor > 0) carrinho[id] = valor; else delete carrinho[id];
  atualizarTotal();
});

const atualizarTotal = () => {
  let total = 0;
  Object.keys(carrinho).forEach(k => {
    const p = pratos.find(x => x.id === Number(k));
    if (p) total += (p.precoPromo || p.preco) * carrinho[k];
  });
  totalValueSpan.textContent = formatarPreco(total);
};

// MENU HAMBURGUER + MODO ESCURO + SCROLL UP
// ===== MENU HAMBÚRGUER =====
const hamburger = document.getElementById('hamburger');
const navLinks = document.getElementById('nav-links');
hamburger.addEventListener('click', () => {
  navLinks.classList.toggle('show');
  hamburger.innerHTML = navLinks.classList.contains('show') ? "&times;" : "&#9776;";
});

// Fechamento suave do menu ao clicar nos links
const links = navLinks.querySelectorAll('a');
links.forEach(link => {
  link.addEventListener('click', (e) => {
    if (navLinks.classList.contains('show')) {
      e.preventDefault();
      navLinks.classList.remove('show');
      hamburger.innerHTML = "&#9776;";
      setTimeout(() => { window.location.href = link.href; }, 500);
    }
  });
});

if (localStorage.getItem("darkMode") === "true") {
  document.body.classList.add("dark-mode");
  document.getElementById("modo-btn").checked = true;
}
document.getElementById("modo-btn").addEventListener("change", e => {
  document.body.classList.toggle("dark-mode", e.target.checked);
  localStorage.setItem("darkMode", e.target.checked);
});

const scrollBtn = document.getElementById("scroll-up-btn");
window.addEventListener("scroll", () => scrollBtn.classList.toggle("show", window.scrollY > 500));
scrollBtn.addEventListener("click", () => menuCategories.scrollIntoView({ behavior: "smooth" }));

// INICIA
renderCategorias();
renderFiltro();
renderPratos();