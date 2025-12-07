const hamburger = document.getElementById('hamburger');
const navLinks = document.getElementById('nav-links');
const modoBtn = document.getElementById('modo-btn');

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
// Carrega preferência salva no localStorage
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
