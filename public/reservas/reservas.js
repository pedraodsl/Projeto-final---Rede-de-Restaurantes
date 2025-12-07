// reservas.js — 100% FUNCIONAL
document.addEventListener("DOMContentLoaded", () => {
  const hamburger   = document.getElementById("hamburger");
  const navLinks    = document.getElementById("nav-links");
  const modoBtn     = document.getElementById("modo-btn");
  const form        = document.getElementById("form-reserva");
  const sucesso     = document.getElementById("mensagem-sucesso");
  const selectPessoas = document.getElementById("pessoas");
  const campoMais   = document.getElementById("campo-mais-pessoas");
  const numeroExato = document.getElementById("numeroExato");

  // MODO ESCURO
  if (localStorage.getItem("darkMode") === "true") {
    modoBtn.checked = true;
    document.body.classList.add("dark-mode");
  }
  modoBtn.addEventListener("change", () => {
    const isDark = modoBtn.checked;
    document.body.classList.toggle("dark-mode", isDark);
    localStorage.setItem("darkMode", isDark);
  });

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

  // CAMPO +8 PESSOAS
  selectPessoas.addEventListener("change", () => {
    if (selectPessoas.value === "mais") {
      campoMais.style.display = "block";
      numeroExato.required = true;
    } else {
      campoMais.style.display = "none";
      numeroExato.required = false;
      numeroExato.value = "";
    }
  });

  // ENVIO DO FORMULÁRIO
  /*form.addEventListener("submit", (e) => {
    e.preventDefault();
    form.style.opacity = "0";
    setTimeout(() => {
      form.style.display = "none";
      sucesso.style.display = "block";
      setTimeout(() => sucesso.style.opacity = "1", 100);
    }, 400);
  });*/
});