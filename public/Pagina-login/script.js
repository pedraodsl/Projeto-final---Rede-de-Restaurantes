document.addEventListener('DOMContentLoaded', () => {
  const modoBtn = document.getElementById('modo-btn');
  const hamburger = document.getElementById('hamburger');
  const navLinks = document.getElementById('nav-links');

  // Modo escuro
  if (localStorage.getItem('darkMode') === 'true') {
    document.body.classList.add('dark-mode');
    modoBtn.checked = true;
  }
  modoBtn.addEventListener('change', () => {
    document.body.classList.toggle('dark-mode');
    localStorage.setItem('darkMode', modoBtn.checked);
  });

  // Menu mobile
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

  // Trocar abas
  document.querySelectorAll('.tab').forEach(tab => {
    tab.addEventListener('click', () => {
      document.querySelectorAll('.tab, .form-box').forEach(el => el.classList.remove('active'));
      tab.classList.add('active');
      document.getElementById(tab.dataset.type).classList.add('active');
    });
  });

  // Máscara CPF automática
  /*document.querySelectorAll('.cpf-mask').forEach(input => {
    input.addEventListener('input', e => {
      let v = e.target.value.replace(/\D/g, '');
      v = v.replace(/(\d{3})(\d)/, '$1.$2');
      v = v.replace(/(\d{3})(\d)/, '$1.$2');
      v = v.replace(/(\d{3})(\d{1,2})$/, '$1-$2');
      e.target.value = v;
    });
  });*/

  // Mostrar/ocultar senha
  document.querySelectorAll('.toggle-pass').forEach(el => {
    el.addEventListener('click', () => {
      const input = el.previousElementSibling;
      input.type = input.type === 'password' ? 'text' : 'password';
      el.textContent = input.type === 'password' ? 'Mostrar' : 'Esconder';
    });
  });

  /*// Login Cliente
  document.getElementById('form-login-cliente').addEventListener('submit', e => {
    e.preventDefault();
    const cpf = document.getElementById('cliente-cpf').value.replace(/\D/g, '');
    const senha = document.getElementById('cliente-senha').value;

    const usuarios = JSON.parse(localStorage.getItem('usuariosBellor') || '[]');
    const usuario = usuarios.find(u => u.cpf === cpf && u.senha === senha);

    if (usuario) {
      localStorage.setItem('usuarioLogado', JSON.stringify(usuario));
      alert('Login realizado com sucesso!');
      window.location.href = 'perfil-cliente.html';
    } else {
      document.getElementById('erro-cliente').textContent = 'CPF ou senha incorretos';
    }
  });*/

  // Login Admin (só e-mail + senha)
  /*document.getElementById('form-login-admin').addEventListener('submit', e => {
    e.preventDefault();
    const email = document.getElementById('admin-email').value.trim();
    const senha = document.getElementById('admin-senha').value;

    const admins = JSON.parse(localStorage.getItem('adminsBellor') || '[]');
    const admin = admins.find(a => a.email === email && a.senha === senha);

    if (admin) {
      localStorage.setItem('adminLogado', JSON.stringify(admin));
      alert('Bem-vindo ao painel administrativo!');
      window.location.href = 'admin.html';
    } else {
      document.getElementById('erro-admin').textContent = 'E-mail ou senha incorretos';
    }
  });*/
});