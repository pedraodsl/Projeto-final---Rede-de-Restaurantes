const API = '/api/admin'; // ajuste se necessário

document.addEventListener('DOMContentLoaded', () => {
  iniciarNavegacao();
  carregarTudo();
});

function iniciarNavegacao() {
  document.querySelectorAll('.sidebar-nav a').forEach(link => {
    link.addEventListener('click', e => {
      e.preventDefault();
      const target = link.getAttribute('href').substring(1);
      document.querySelectorAll('.section').forEach(s => s.classList.remove('active'));
      document.querySelectorAll('.sidebar-nav a').forEach(l => l.classList.remove('active'));
      document.getElementById(target).classList.add('active');
      link.classList.add('active');
    });
  });

  // Botões principais
  document.getElementById('btn-editar-perfil')?.addEventListener('click', abrirModalPerfil);
  document.getElementById('btn-nova-unidade')?.addEventListener('click', () => abrirModalRestaurante());
  document.getElementById('btn-novo-prato')?.addEventListener('click', () => abrirModalPrato());
  document.getElementById('logout-btn')?.addEventListener('click', () => {
    fetch('/api/logout', {method: 'POST'}).then(() => location.href = '/login.php');
  });
}

async function carregarTudo() {
  try {
    const res = await fetch(`${API}/dashboard`, { credentials: 'include' });
    if (!res.ok) throw new Error('Não autorizado');
    const data = await res.json();

    // Perfil
    document.getElementById('campo-nome').textContent = data.usuario.nome;
    document.getElementById('campo-email').textContent = data.usuario.email;
    document.getElementById('campo-telefone').textContent = data.usuario.telefone || '-';
    document.getElementById('campo-2fa').textContent = data.usuario.tfa ? 'Ativado' : 'Desativado';
    document.getElementById('campo-2fa').className = data.usuario.tfa ? 'status on' : 'status off';
    document.getElementById('campo-ultimo-login').textContent = new Date(data.usuario.ultimo_login).toLocaleString();

    // Restaurantes
    renderizarRestaurantes(data.restaurantes);

    // Cardápio
    renderizarPratos(data.pratos);

    // Relatórios
    document.getElementById('vendas-hoje').textContent = `R$ ${data.estatisticas.vendas_hoje.toLocaleString('pt-BR')}`;
    document.getElementById('novos-clientes').textContent = data.estatisticas.novos_clientes;

    // Gráfico
    new Chart(document.getElementById('grafico-vendas'), {
      type: 'line',
      data: {
        labels: data.grafico.labels,
        datasets: [{
          label: 'Vendas Diárias',
          data: data.grafico.valores,
          borderColor: '#680505',
          tension: 0.4,
          fill: true
        }]
      },
      options: { responsive: true }
    });

  } catch (err) {
    alert('Erro ao carregar painel. Faça login novamente.');
    location.href = '/login.php';
  }
}

// === FUNÇÕES DE RENDERIZAÇÃO ===
function renderizarRestaurantes(lista) {
  const container = document.getElementById('lista-restaurantes');
  container.innerHTML = lista.map(r => `
    <div class="restaurante-card">
      <h3>${r.nome} - ${r.cidade}</h3>
      <p>Status: <span class="status ${r.aberto ? 'on' : 'off'}">${r.aberto ? 'Aberto' : 'Fechado'}</span></p>
      <p>${r.endereco}</p>
      <button class="btn-small" onclick="editarRestaurante(${r.id})">Editar</button>
      <button class="btn-small btn-danger" onclick="excluirRestaurante(${r.id})">Excluir</button>
    </div>
  `).join('');
}

function renderizarPratos(lista) {
  const tbody = document.getElementById('lista-pratos');
  tbody.innerHTML = lista.map(p => `
    <tr>
      <td>${p.nome}</td>
      <td>R$ ${p.preco.toFixed(2)}</td>
      <td>${p.categoria}</td>
      <td><span class="status ${p.disponivel ? 'on' : 'off'}">${p.disponivel ? 'Disponível' : 'Indisponível'}</span></td>
      <td>
        <button class="btn-small" onclick="editarPrato(${p.id})">Editar</button>
        <button class="btn-small btn-danger" onclick="excluirPrato(${p.id})">Excluir</button>
      </td>
    </tr>
  `).join('');
}

// === MODAIS ===
function abrirModalPerfil() {
  criarModal({
    titulo: 'Editar Perfil',
    campos: [
      { label: 'Nome', id: 'nome', value: document.getElementById('campo-nome').textContent },
      { label: 'Telefone', id: 'telefone', value: document.getElementById('campo-telefone').textContent }
    ],
    onSalvar: async (dados) => {
      await fetch(`${API}/perfil`, { method: 'PUT', headers: {'Content-Type': 'application/json'}, body: JSON.stringify(dados), credentials: 'include' });
      location.reload();
    }
  });
}

function abrirModalRestaurante(restaurante = {}) {
  criarModal({
    titulo: restaurante.id ? 'Editar Unidade' : 'Nova Unidade',
    campos: [
      { label: 'Nome da Unidade', id: 'nome', value: restaurante.nome || '' },
      { label: 'Cidade', id: 'cidade', value: restaurante.cidade || '' },
      { label: 'Endereço', id: 'endereco', value: restaurante.endereco || '' }
    ],
    onSalvar: async (dados) => {
      const method = restaurante.id ? 'PUT' : 'POST';
      const url = restaurante.id ? `${API}/restaurantes/${restaurante.id}` : `${API}/restaurantes`;
      await fetch(url, { method, headers: {'Content-Type': 'application/json'}, body: JSON.stringify(dados), credentials: 'include' });
      carregarTudo();
    }
  });
}

function abrirModalPrato(prato = {}) {
  criarModal({
    titulo: prato.id ? 'Editar Prato' : 'Novo Prato',
    campos: [
      { label: 'Nome do Prato', id: 'nome', value: prato.nome || '' },
      { label: 'Preço', id: 'preco', value: prato.preco || '', type: 'number' },
      { label: 'Categoria', id: 'categoria', value: prato.categoria || '', type: 'text' }
    ],
    onSalvar: async (dados) => {
      dados.preco = parseFloat(dados.preco);
      const method = prato.id ? 'PUT' : 'POST';
      const url = prato.id ? `${API}/pratos/${prato.id}` : `${API}/pratos`;
      await fetch(url, { method, headers: {'Content-Type': 'application/json'}, body: JSON.stringify(dados), credentials: 'include' });
      carregarTudo();
    }
  });
}

// Modal genérico (reutilizável)
function criarModal({ titulo, campos, onSalvar }) {
  const modal = document.createElement('div');
  modal.className = 'modal';
  modal.innerHTML = `
    <div class="modal-content">
      <h2>${titulo}</h2>
      ${campos.map(c => `<label>${c.label}<input id="${c.id}" type="${c.type || 'text'}" value="${c.value}"></label>`).join('')}
      <div style="margin-top: 1.5rem; text-align: right;">
        <button onclick="this.closest('.modal').remove()">Cancelar</button>
        <button class="btn-primary" id="btn-salvar-modal">Salvar</button>
      </div>
    </div>
  `;
  document.body.appendChild(modal);

  document.getElementById('btn-salvar-modal').addEventListener('click', () => {
    const dados = {};
    campos.forEach(c => dados[c.id] = document.getElementById(c.id).value);
    onSalvar(dados);
    modal.remove();
  });
}

// Funções globais para editar/excluir
function editarRestaurante(id) { /* buscar dados e abrir modal */ }
function excluirRestaurante(id) { if(confirm('Excluir?')) fetch(`${API}/restaurantes/${id}`, {method: 'DELETE'}).then(carregarTudo); }
function editarPrato(id) { /* mesmo esquema */ }
function excluirPrato(id) { if(confirm('Excluir prato?')) fetch(`${API}/pratos/${id}`, {method: 'DELETE'}).then(carregarTudo); }