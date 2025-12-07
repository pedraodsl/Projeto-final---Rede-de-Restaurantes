document.addEventListener('DOMContentLoaded', () => {
  const modoBtn = document.getElementById('modo-btn');
  const hamburger = document.getElementById('hamburger');
  const navLinks = document.getElementById('nav-links');

  // Modo escuro + menu (igual ao login.js)
  if (localStorage.getItem('darkMode') === 'true') {
    document.body.classList.add('dark-mode');
    modoBtn.checked = true;
  }
  modoBtn.addEventListener('change', () => {
    document.body.classList.toggle('dark-mode');
    localStorage.setItem('darkMode', modoBtn.checked);
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


  // Trocar abas + máscara CPF + toggle senha (igual ao login.js)
  document.querySelectorAll('.tab').forEach(tab => {
    tab.addEventListener('click', () => {
      document.querySelectorAll('.tab, .form-box').forEach(el => el.classList.remove('active'));
      tab.classList.add('active');
      document.getElementById(tab.dataset.type).classList.add('active');
    });
  });

  /*document.querySelectorAll('.cpf-mask').forEach(input => {
    input.addEventListener('input', e => {
      let v = e.target.value.replace(/\D/g, '');
      v = v.replace(/(\d{3})(\d)/, '$1.$2');
      v = v.replace(/(\d{3})(\d)/, '$1.$2');
      v = v.replace(/(\d{3})(\d{1,2})$/, '$1-$2');
      e.target.value = v;
    });
  });*/

  document.querySelectorAll('.toggle-pass').forEach(el => {
    el.addEventListener('click', () => {
      const input = el.previousElementSibling;
      input.type = input.type === 'password' ? 'text' : 'password';
      el.textContent = input.type === 'password' ? 'Mostrar' : 'Esconder';
    });
  });

  // Cadastro Cliente
 /* document.getElementById('form-cadastro-cliente').addEventListener('submit', e => {
    e.preventDefault();
    const usuario = {
      nome: document.getElementById('nome').value.trim(),
      cpf: document.getElementById('cpf').value.replace(/\D/g, ''),
      senha: document.getElementById('senha').value
    };

    if (usuario.cpf.length !== 11) return alert('CPF inválido');

    const usuarios = JSON.parse(localStorage.getItem('usuariosBellor') || '[]');
    if (usuarios.some(u => u.cpf === usuario.cpf)) return alert('CPF já cadastrado');

    usuarios.push(usuario);
    localStorage.setItem('usuariosBellor', JSON.stringify(usuarios));
    document.getElementById('sucesso').textContent = 'Cadastro realizado com sucesso!';
    setTimeout(() => window.location.href = 'login.php', 2000);
  });

  // Cadastro Admin
  document.getElementById('form-cadastro-admin').addEventListener('submit', e => {
    e.preventDefault();
    const admin = {
      restaurante: document.getElementById('restaurante').value.trim(),
      cidade: document.getElementById('cidade').value.trim(),
      nome: document.getElementById('nome-admin').value.trim(),
      email: document.getElementById('email').value.trim(),
      cpf: document.getElementById('cpf-admin').value.replace(/\D/g, ''),
      codigo: document.getElementById('codigo').value.toUpperCase().trim(),
      senha: document.getElementById('senha-admin').value
    };

    const admins = JSON.parse(localStorage.getItem('adminsBellor') || '[]');
    if (admins.some(a => a.email === admin.email)) return alert('E-mail já cadastrado como administrador');

    admins.push(admin);
    localStorage.setItem('adminsBellor', JSON.stringify(admins));
    alert('Administrador cadastrado com sucesso!\nAgora você pode fazer login com e-mail e senha.');
    window.location.href = 'login.php';
  });*/
});