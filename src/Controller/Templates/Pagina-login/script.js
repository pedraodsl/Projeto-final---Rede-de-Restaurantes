// ===== ELEMENTOS =====
const hamburger = document.getElementById('hamburger');
const navLinks = document.getElementById('nav-links');
const modoBtn = document.getElementById('modo-btn');

const categorias = document.querySelectorAll(".category");

// ===== MENU HAMBÚRGUER =====
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

// ===== MODO ESCURO / CLARO =====
if(localStorage.getItem('darkMode') === 'true'){
  document.body.classList.add('dark-mode');
  modoBtn.checked = true;
}

modoBtn.addEventListener('change', () => {
  if(modoBtn.checked){
    document.body.classList.add('dark-mode');
    localStorage.setItem('darkMode', 'true');
  } else {
    document.body.classList.remove('dark-mode');
    localStorage.setItem('darkMode', 'false');
  }
});

// ===== ANIMAÇÃO AO ROLAR =====
function revelarCategorias() {
  const limiteVisivel = window.innerHeight * 1.2;
  categorias.forEach((cat) => {
    const topo = cat.getBoundingClientRect().top;
    if (topo < limiteVisivel) {
      cat.classList.add("visible");
    }
  });
}
window.addEventListener("scroll", revelarCategorias);
window.addEventListener("load", revelarCategorias);

// ===== FILTRO MENU =====
const filterBtn = document.querySelector(".filter-btn");
const filterOptions = document.querySelector(".filter-options");
let filtroAtivo = false;

// Opções do dropdown
const opcoes = [
  {id: "entradas", nome: "Entradas"},
  {id: "principais", nome: "Pratos principais"},
  {id: "acompanhamentos", nome: "Acompanhamentos"},
  {id: "sobremesas", nome: "Sobremesas"},
  {id: "bebidas", nome: "Bebidas"},
  {id: "especialidades", nome: "Especialidades da Casa"},
   {id: "opcoes", nome: "Opções veganas"},
  {id: "ultimos", nome: "Últimos do dia"},
];

// Cria opções iniciais
function criarOpcoesDropdown() {
  filterOptions.innerHTML = "";
  opcoes.forEach(op => {
    const li = document.createElement("li");
    li.textContent = op.nome;
    li.dataset.target = op.id;
    filterOptions.appendChild(li);
  });
}
criarOpcoesDropdown();

// Abrir/Fechar dropdown
filterBtn.addEventListener("click", () => {
  filterOptions.classList.toggle("show");
  filterBtn.classList.toggle("open"); // seta rotaciona
});

// Seleção de filtro
filterOptions.addEventListener("click", (e) => {
  if(e.target.tagName === "LI"){
    const alvo = e.target.dataset.target;

    if(alvo === "remover"){
      filterBtn.firstChild.textContent = "Filtrar ";
      e.target.remove(); // remove a opção remover
      filtroAtivo = false;
    } else {
      filterBtn.firstChild.textContent = e.target.textContent + " ";
      if(!filtroAtivo){
        const remover = document.createElement("li");
        remover.textContent = "Remover filtro";
        remover.dataset.target = "remover";
        remover.classList.add("remove-filter");
        filterOptions.appendChild(remover);
        filtroAtivo = true;
      }
    }
    filterOptions.classList.remove("show");
    filterBtn.classList.remove("open");
  }
});

// ===== OBSERVER PARA ANIMAÇÃO MAIS SUAVE =====
const observer = new IntersectionObserver(entries => {
  entries.forEach(entry => {
    if(entry.isIntersecting) entry.target.classList.add("visible");
  });
}, { threshold: 0.1 });

document.querySelectorAll(".category").forEach(cat => observer.observe(cat));

// ===== Controles de quantidade =====
document.querySelectorAll('.quantity-selector').forEach(selector => {
  const minusBtn = selector.querySelector('.minus');
  const plusBtn = selector.querySelector('.plus');
  const qty = selector.querySelector('.quantity');

  minusBtn.addEventListener('click', () => {
    let current = parseInt(qty.textContent);
    if(current > 0) qty.textContent = current - 1;
  });

  plusBtn.addEventListener('click', () => {
    let current = parseInt(qty.textContent);
    qty.textContent = current + 1;
  });
});

const scrollUpBtn = document.getElementById('scroll-up-btn');
const menuCategories = document.querySelector('.menu-categories');
const offset = 620; // distância em px acima do topo do menu-categories

// Mostrar/ocultar botão ao rolar
function toggleScrollUpBtn() {
  const categoriasTopo = menuCategories.getBoundingClientRect().top;
  if (categoriasTopo < 0) {
    scrollUpBtn.classList.add('show');
  } else {
    scrollUpBtn.classList.remove('show');
  }
}

window.addEventListener('scroll', toggleScrollUpBtn);

// Ao clicar, sobe suavemente até o topo do menu-categories com offset
scrollUpBtn.addEventListener('click', () => {
  const posicao = menuCategories.offsetTop - offset;
  window.scrollTo({ top: posicao, behavior: 'smooth' });
});