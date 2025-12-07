// promocoes.js
document.addEventListener('DOMContentLoaded', () => {
  const modoBtn = document.getElementById('modo-btn');
  const hamburger = document.getElementById('hamburger');
  const navLinks = document.getElementById('nav-links');
  const form = document.getElementById('form-cupom');
  const listaCupons = document.getElementById('lista-cupons');
  const contador = document.getElementById('contador-cupons');

  let cupons = JSON.parse(localStorage.getItem('cuponsBellor')) || [];

  // === MODO ESCURO ===
  if (localStorage.getItem('darkMode') === 'true') {
    document.body.classList.add('dark-mode');
    modoBtn.checked = true;
  }
  modoBtn.addEventListener('change', () => {
    document.body.classList.toggle('dark-mode');
    localStorage.setItem('darkMode', modoBtn.checked);
  });

  // === MENU MOBILE ===
  hamburger.addEventListener('click', () => {
    navLinks.classList.toggle('show');
    hamburger.innerHTML = navLinks.classList.contains('show') ? '×' : 'Menu';
  });

  // === SALVAR CUPONS ===
  function salvarCupons() {
    localStorage.setItem('cuponsBellor', JSON.stringify(cupons));
    atualizarLista();
  }

  // === CRIAR CUPOM ===
  form.addEventListener('submit', (e) => {
    e.preventDefault();
    
    const novoCupom = {
      id: Date.now(),
      nome: document.getElementById('nome-cupom').value.trim(),
      codigo: document.getElementById('codigo-cupom').value.trim().toUpperCase(),
      desconto: parseInt(document.getElementById('desconto').value),
      validade: document.getElementById('validade').value,
      tipo: document.getElementById('tipo-cupom').value,
      ativo: true
    };

    cupons.push(novoCupom);
    salvarCupons();
    form.reset();
    alert(`Cupom ${novoCupom.codigo} criado com sucesso!`);
  });

  // === ATUALIZAR LISTA ===
  function atualizarLista() {
    listaCupons.innerHTML = '';
    const ativos = cupons.filter(c => c.ativo);

    contador.textContent = ativos.length;

    if (cupons.length === 0) {
      listaCupons.innerHTML = '<p style="text-align:center; color:#999; padding:2rem;">Nenhum cupom criado ainda.</p>';
      return;
    }

    cupons.forEach(cupom => {
      const valido = new Date(cupom.validade) >= new Date();
      const status = cupom.ativo && valido ? 'Ativo' : 'Inativo';

      const card = document.createElement('div');
      card.className = 'cupom-card';
      if (!cupom.ativo || !valido) card.style.opacity = '0.6';

      card.innerHTML = `
        <div class="cupom-info">
          <h3>${cupom.nome}</h3>
          <p><strong>Código:</strong> <code style="background:#eee;padding:4px 8px;border-radius:4px;">${cupom.codigo}</code></p>
          <p><strong>Desconto:</strong> ${cupom.desconto}% • <strong>Válido até:</strong> ${new Date(cupom.validade).toLocaleDateString('pt-BR')}</p>
          <span class="cupom-badge badge-${cupom.tipo}">${cupom.tipo === 'doacao' ? 'SOMENTE DOADORES' : 'TODOS OS CLIENTES'}</span>
        </div>
        <div class="cupom-actions">
          <button class="btn-${cupom.ativo ? 'desativar' : 'ativar'}" data-id="${cupom.id}">
            ${cupom.ativo ? 'Desativar' : 'Ativar'}
          </button>
          <button class="btn-excluir" data-id="${cupom.id}">Excluir</button>
        </div>
      `;
      listaCupons.appendChild(card);
    });

    // Eventos dos botões
    document.querySelectorAll('.btn-ativar, .btn-desativar').forEach(btn => {
      btn.onclick = () => {
        const id = parseInt(btn.dataset.id);
        const cupom = cupons.find(c => c.id === id);
        cupom.ativo = !cupom.ativo;
        salvarCupons();
      };
    });

    document.querySelectorAll('.btn-excluir').forEach(btn => {
      btn.onclick = () => {
        if (confirm('Tem certeza que deseja excluir este cupom?')) {
          const id = parseInt(btn.dataset.id);
          cupons = cupons.filter(c => c.id !== id);
          salvarCupons();
        }
      };
    });
  }

  // Iniciar
  atualizarLista();
});