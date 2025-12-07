// projeto.js
const donationOptions = [
  {
    title: "Como ajudar",
    content: "Escolha a forma mais conveniente para você contribuir com nosso projeto social. Sua ajuda faz a diferença na vida de muitas pessoas.",
    highlighted: true,
    openByDefault: true
  },
  {
    title: "Doação Online",
    content: "Faça sua doação de forma rápida e segura através de nossa plataforma online. Aceitamos diferentes formas de pagamento.",
    highlighted: false
  },
  {
    title: "Contato Corporativo",
    content: "Para parcerias empresariais e doações corporativas, entre em contato através do email: <strong>restaurantes@bellor.com.br</strong>",
    highlighted: false
  }
];

document.addEventListener("DOMContentLoaded", () => {
  const accordion = document.getElementById("donation-accordion");

  // Cria os itens do accordion dinamicamente
  donationOptions.forEach((opt, i) => {
    const item = document.createElement("div");
    item.className = `accordion-item${opt.openByDefault ? " active" : ""}`;

    item.innerHTML = `
      <div class="accordion-header">
        <span class="${opt.highlighted ? "highlight" : ""}">${opt.title}</span>
        <div class="arrow"></div>
      </div>
      <div class="accordion-content">
        <p>${opt.content}</p>
      </div>
    `;
    accordion.appendChild(item);
  });

  // Accordion click
  accordion.addEventListener("click", (e) => {
    const header = e.target.closest(".accordion-header");
    if (!header) return;

    const item = header.parentElement;
    const wasActive = item.classList.contains("active");

    // Fecha todos
    document.querySelectorAll(".accordion-item").forEach(i => {
      i.classList.remove("active");
      i.querySelector(".accordion-content").style.maxHeight = null;
    });

    // Abre o clicado
    if (!wasActive) {
      item.classList.add("active");
      const content = item.querySelector(".accordion-content");
      content.style.maxHeight = content.scrollHeight + "px";
    }
  });

  // Abre o primeiro por padrão
  const first = document.querySelector(".accordion-item.active .accordion-content");
  if (first) first.style.maxHeight = first.scrollHeight + "px";

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


  // MODO ESCURO
  const modoBtn = document.getElementById("modo-btn");
  if (localStorage.getItem("darkMode") === "true") {
    modoBtn.checked = true;
    document.body.classList.add("dark-mode");
  }

  modoBtn.addEventListener("change", () => {
    document.body.classList.toggle("dark-mode", modoBtn.checked);
    localStorage.setItem("darkMode", modoBtn.checked);
  });
});